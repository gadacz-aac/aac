import 'dart:async';
import 'dart:math' as math;

import 'package:aac/src/database/daos/child_communication_symbol_dao.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/card/child_symbol_card.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/model/child_communication_symbol.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:flutter/gestures.dart' show HitTestResult;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderBox, RenderMetaData;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../symbols/model/communication_symbol.dart';

/// Edit-mode grid with drag & drop.
///
/// Symbols are placed on slots identified by their `position` in
/// `child_symbol_tb`. Positions don't have to be dense - a missing position
/// renders as a free slot that symbols can be dropped on, like files on a
/// desktop. Free slots are invisible until something is being dragged.
class SymbolsGridWithDrag extends ConsumerStatefulWidget {
  const SymbolsGridWithDrag({required this.board, super.key});

  final Board board;
  @override
  ConsumerState<SymbolsGridWithDrag> createState() =>
      _SymbolsGridWithDragState();
}

class _SymbolsGridWithDragState extends ConsumerState<SymbolsGridWithDrag> {
  DragItem<ChildCommunicationSymbol>? currentlyDragged;
  int? desiredIndex;
  Offset dragStartPosition = Offset.zero;
  bool didDraggedSignificantly = false;

  // Auto-scrolls the grid while a symbol is dragged near its top or bottom
  // edge. The closer the pointer is to the edge, the faster it scrolls.
  static const double _autoScrollEdgeZone = 80.0;
  static const double _minAutoScrollSpeed = 150.0; // px/s at the zone border
  static const double _maxAutoScrollSpeed = 900.0; // px/s at the very edge
  static const Duration _autoScrollInterval = Duration(milliseconds: 16);

  Timer? _autoScrollTimer;
  Offset _lastDragPointerPosition = Offset.zero;
  bool _hoverRefreshScheduled = false;

  void _onLongPress(CommunicationSymbol symbol, WidgetRef ref) {
    if (ref.read(isParentModeProvider)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
    }
  }

  RenderBox? get _gridBox {
    final controller = ref.read(symbolGridScrollControllerProvider);
    if (!controller.hasClients) return null;

    final renderObject =
        controller.position.context.storageContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached) return null;
    return renderObject;
  }

  /// Signed scroll speed (px/s) for the pointer position: negative scrolls
  /// up, positive scrolls down. 0 means the pointer is away from the edges,
  /// null means the speed can't be resolved or the pointer is outside the
  /// grid.
  double? _autoScrollSpeedFor(Offset globalPointerPosition) {
    final box = _gridBox;
    if (box == null) return null;

    final local = box.globalToLocal(globalPointerPosition);
    if (local.dy < 0 || local.dy > box.size.height) return null;

    final double distanceToEdge;
    if (local.dy < _autoScrollEdgeZone) {
      distanceToEdge = local.dy;
    } else if (local.dy > box.size.height - _autoScrollEdgeZone) {
      distanceToEdge = box.size.height - local.dy;
    } else {
      return 0;
    }

    final progress = 1 - distanceToEdge / _autoScrollEdgeZone;
    final speed = _minAutoScrollSpeed +
        progress * (_maxAutoScrollSpeed - _minAutoScrollSpeed);
    return local.dy < _autoScrollEdgeZone ? -speed : speed;
  }

  void _updateAutoScroll(Offset globalPointerPosition) {
    _lastDragPointerPosition = globalPointerPosition;

    final controller = ref.read(symbolGridScrollControllerProvider);
    if (!controller.hasClients || controller.position.maxScrollExtent <= 0) {
      return;
    }

    final speed = _autoScrollSpeedFor(globalPointerPosition) ?? 0;
    if (speed == 0) {
      _stopAutoScroll();
    } else {
      _autoScrollTimer ??=
          Timer.periodic(_autoScrollInterval, (_) => _autoScrollTick());
    }
  }

  void _autoScrollTick() {
    if (currentlyDragged == null) {
      _stopAutoScroll();
      return;
    }

    final controller = ref.read(symbolGridScrollControllerProvider);
    if (!controller.hasClients) {
      _stopAutoScroll();
      return;
    }

    // Re-evaluate the speed from the latest pointer position: the pointer
    // might have left the edge zone (or the grid) since the last event.
    final speed = _autoScrollSpeedFor(_lastDragPointerPosition) ?? 0;
    if (speed == 0) {
      _stopAutoScroll();
      return;
    }

    final position = controller.position;
    final step = speed * _autoScrollInterval.inMilliseconds / 1000;
    final target = (controller.offset + step)
        .clamp(0.0, position.maxScrollExtent)
        .toDouble();
    if (target == controller.offset) return; // already scrolled to the edge

    controller.jumpTo(target);

    // jumpTo only schedules a relayout, the tiles move on the next frame,
    // so the hovered tile has to be resolved after this frame is laid out.
    _scheduleHoverRefresh();
  }

  /// Re-hit-tests the last pointer position once the current frame is laid
  /// out and updates the hovered slot. DragTarget callbacks (onMove/onLeave)
  /// only fire when the pointer moves, but while auto-scrolling the tiles
  /// move under a still pointer - without this the reorder preview and the
  /// drop position would lag behind the scrolled grid.
  void _scheduleHoverRefresh() {
    if (_hoverRefreshScheduled) return;
    _hoverRefreshScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hoverRefreshScheduled = false;
      if (!mounted || currentlyDragged == null) return;

      final hoveredSlot = _hoveredTileIndex(_lastDragPointerPosition);
      if (hoveredSlot != desiredIndex) {
        setState(() {
          desiredIndex = hoveredSlot;
        });
      }
    });
  }

  int? _hoveredTileIndex(Offset globalPosition) {
    final result = HitTestResult();
    WidgetsBinding.instance
        .hitTestInView(result, globalPosition, View.of(context).viewId);

    for (final entry in result.path) {
      final target = entry.target;
      if (target is RenderMetaData && target.metaData is _TileMeta) {
        return (target.metaData as _TileMeta).index;
      }
    }
    return null;
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  @override
  void dispose() {
    _stopAutoScroll();
    super.dispose();
  }

  /// Maps symbols to grid slots. A slot is a symbol's `position`, so missing
  /// positions become free (null) slots. Always appends at least one extra
  /// row of free slots, so there is always somewhere to drag a symbol to.
  List<ChildCommunicationSymbol?> _buildSlots(
      List<ChildCommunicationSymbol> symbols, int crossAxisCount) {
    var maxPosition = -1;
    for (final symbol in symbols) {
      if (symbol.position > maxPosition) maxPosition = symbol.position;
    }

    final rowsForSymbols = (symbols.length / crossAxisCount).ceil();
    final rowsForPositions = ((maxPosition + 1) / crossAxisCount).ceil();
    final rows = math.max(rowsForSymbols, rowsForPositions);
    final slotCount = (rows + 1) * crossAxisCount;

    final slots = List<ChildCommunicationSymbol?>.filled(slotCount, null);
    for (final symbol in symbols) {
      var slot = symbol.position < 0 ? 0 : symbol.position;
      // defensive: duplicated positions land in the next free slot
      while (slot < slots.length && slots[slot] != null) {
        slot++;
      }
      if (slot >= slots.length) {
        slots.add(symbol);
      } else {
        slots[slot] = symbol;
      }
    }
    return slots;
  }

  ChildCommunicationSymbol _copyAtSlot(
      ChildCommunicationSymbol symbol, int slot) {
    return ChildCommunicationSymbol(
      id: symbol.id,
      label: symbol.label,
      imagePath: symbol.imagePath,
      vocalization: symbol.vocalization,
      color: symbol.color,
      isDeleted: symbol.isDeleted,
      childBoardId: symbol.childBoardId,
      position: slot,
      hidden: symbol.hidden,
      parentBoardId: symbol.parentBoardId,
    );
  }

  void _handleDrop(List<ChildCommunicationSymbol> symbols,
      List<ChildCommunicationSymbol?> slots) {
    if (currentlyDragged == null || desiredIndex == null) return;

    final origin = currentlyDragged!.index;
    final target = desiredIndex!;
    final dragged = currentlyDragged!.data;

    if (origin == target) {
      setState(() {
        desiredIndex = null;
      });
      return;
    }

    final arrangement = [...slots];
    arrangement[origin] = null;

    final isTargetOccupied =
        target < arrangement.length && arrangement[target] != null;

    if (isTargetOccupied) {
      // Dropped on a symbol: the dragged one takes the hovered slot and the
      // in-between symbols shift towards the freed origin slot.
      arrangement.removeAt(origin);
      arrangement.insert(target, dragged);
    } else {
      // Dropped on a free slot: nothing shifts, the origin slot becomes a
      // free space - like moving files on a desktop.
      arrangement[target] = dragged;
    }

    final positionUpdates = <int, int>{};
    final updatedSymbols = <ChildCommunicationSymbol>[];
    for (var slot = 0; slot < arrangement.length; slot++) {
      final symbol = arrangement[slot];
      if (symbol == null) continue;

      final updated =
          symbol.position == slot ? symbol : _copyAtSlot(symbol, slot);
      if (!identical(updated, symbol)) positionUpdates[symbol.id] = slot;
      updatedSymbols.add(updated);
    }

    setState(() {
      desiredIndex = null;
      // optimistic update, the stream emits the persisted state right after
      symbols
        ..clear()
        ..addAll(updatedSymbols);
    });

    if (positionUpdates.isNotEmpty) {
      ref
          .read(childSymbolDaoProvider)
          .updatePositions(widget.board.id, positionUpdates);
    }
  }

  /// Free slot placeholder. Sized like an empty [SymbolCard] (the grid gives
  /// tiles unbounded height, so this must size itself intrinsically).
  Widget _buildFreeSlotTile(BuildContext context, int index,
      List<DragItem<CommunicationSymbol>?> incoming) {
    final isDragging = currentlyDragged != null;

    return MetaData(
      metaData: _TileMeta(index),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          // keeps the empty tile hit-testable, so it can be a drop target
          behavior: HitTestBehavior.opaque,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: isDragging ? Border.all(color: Colors.black12) : null,
              color: incoming.isNotEmpty ? Colors.black12 : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
                  child: SizedBox(height: 80),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 6),
                  child: Text('',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(height: 1.25)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final symbols = ref.watch(childSymbolProvider(widget.board.id)).value;

    if (symbols == null) return SizedBox();

    final crossAxisCount = widget.board.crossAxisCount;
    final slots = _buildSlots(symbols, crossAxisCount);

    return BaseSymbolsGrid(
        crossAxisCount: crossAxisCount,
        itemCount: slots.length,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) {
          final symbol = slots[index];

          return DragTarget<DragItem<CommunicationSymbol>>(
              onMove: (data) {
                setState(() {
                  desiredIndex = index;
                });
              },
              onLeave: (data) {
                setState(() {
                  desiredIndex = null;
                });
              },
              onAcceptWithDetails: (data) {
                _handleDrop(symbols, slots);
              },
              builder: (context, incoming, __) {
                if (symbol == null) {
                  return _buildFreeSlotTile(context, index, incoming);
                }

                return LayoutBuilder(builder: (context, constrains) {
                  final data = DragItem(index: index, data: symbol);

                  final Offset offset;

                  final isNotDragging =
                      currentlyDragged == null || desiredIndex == null;
                  final target = desiredIndex;
                  final isTargetOccupied = target != null &&
                      target < slots.length &&
                      slots[target] != null;

                  if (isNotDragging) {
                    offset = const Offset(0, 0);
                  } else {
                    int min = currentlyDragged!.index;
                    int max = target!;
                    if (min > max) {
                      final tmp = min;
                      min = max;
                      max = tmp;
                    }

                    final isNotAffected = index < min || index > max;
                    final isOnSameTile = currentlyDragged?.index == target;
                    final isLastInRow = (index + 1) % crossAxisCount == 0;
                    final isFirstInRow = (index) % crossAxisCount == 0;

                    if (!isTargetOccupied || isNotAffected || isOnSameTile) {
                      // hovering a free slot moves nothing
                      offset = const Offset(0, 0);
                    } else if (currentlyDragged!.index > desiredIndex!) {
                      if (isLastInRow) {
                        offset = Offset(-(crossAxisCount.toDouble() - 1), 1);
                      } else {
                        offset = const Offset(1, 0);
                      }
                    } else {
                      if (isFirstInRow) {
                        offset = Offset((crossAxisCount.toDouble() - 1), -1);
                      } else {
                        offset = const Offset(-1, 0);
                      }
                    }
                  }

                  final child = AnimatedSlide(
                      duration: !isNotDragging
                          ? const Duration(milliseconds: 200)
                          : Duration.zero,
                      offset: offset,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SymbolVisiblityWrapper(
                            hidden: symbol.hidden,
                            child: SymbolCard(symbol: symbol, onTapActions: [
                              SpeakAction(),
                              NavigateToChildBoardAction(),
                              MultiSelectAction(),
                            ])),
                      ));

                  return MetaData(
                    metaData: _TileMeta(index),
                    child: LongPressDraggable(
                      data: data,
                      maxSimultaneousDrags:
                          ref.watch(areSymbolsSelectedProvider) ? 0 : 1,
                      onDragStarted: () {
                        _onLongPress(symbol, ref);
                        setState(() {
                          currentlyDragged = data;
                          dragStartPosition = Offset.zero;
                        });
                      },
                      onDragUpdate: (details) {
                        _updateAutoScroll(details.globalPosition);

                        if (dragStartPosition == Offset.zero) {
                          dragStartPosition = details.globalPosition;
                        } else if (!didDraggedSignificantly &&
                            (dragStartPosition - details.globalPosition)
                                    .distance
                                    .abs() >
                                20) {
                          _onLongPress(symbol, ref);
                          didDraggedSignificantly = true;
                        }
                      },
                      onDragEnd: (_) {
                        _stopAutoScroll();
                        setState(() {
                          currentlyDragged = null;
                          dragStartPosition = Offset.zero;
                          didDraggedSignificantly = false;
                        });
                      },
                      feedback: Material(
                        child: SizedBox(
                            width: constrains.maxWidth,
                            height: constrains.maxHeight.isInfinite
                                ? null
                                : constrains.maxHeight,
                            child: SymbolCard(
                              symbol: symbol,
                              isDragging: true,
                            )),
                      ),
                      childWhenDragging: Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: false,
                          child: child),
                      child: child,
                    ),
                  );
                });
              });
        });
  }
}

class DragItem<T> {
  final int index;
  final T data;

  DragItem({required this.index, required this.data});

  @override
  String toString() {
    return "DragItem $index, $data";
  }
}

/// Identifies a grid slot for hit-testing while auto-scrolling under a still
/// pointer.
class _TileMeta {
  const _TileMeta(this.index);

  final int index;
}
