import 'dart:async';

import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/card/child_symbol_card.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/model/child_communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../symbols/model/communication_symbol.dart';

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

  Timer? _autoScrollTimer;

  // Auto-scroll thresholds
  static const double _scrollZoneSize = 100.0;
  static const double _scrollSpeed = 10.0;

  void _startAutoScroll(
      Offset globalPosition, ScrollController scrollController) {
    // _autoScrollTimer?.cancel();
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPosition = renderBox.globalToLocal(globalPosition);
    final listHeight = renderBox.size.height;

    if (localPosition.dy < _scrollZoneSize) {
      // Near top
      scrollController.jumpTo(
        (scrollController.offset - _scrollSpeed).clamp(
          scrollController.position.minScrollExtent,
          scrollController.position.maxScrollExtent,
        ),
      );
    } else if (localPosition.dy > listHeight - _scrollZoneSize) {
      // Near bottom
      scrollController.jumpTo(
        (scrollController.offset + _scrollSpeed).clamp(
          scrollController.position.minScrollExtent,
          scrollController.position.maxScrollExtent,
        ),
      );
    }
    // _autoScrollTimer?.cancel();
    // });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _onLongPress(CommunicationSymbol symbol, WidgetRef ref) {
    if (ref.read(isParentModeProvider)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
    }
  }

  @override
  Widget build(BuildContext context) {
    final symbols = ref.watch(childSymbolProvider(widget.board.id)).valueOrNull;

    if (symbols == null) return SizedBox();

    final crossAxisCount = widget.board.crossAxisCount;
    final controller = ref.watch(symbolGridScrollControllerProvider);

    return BaseSymbolsGrid(
        crossAxisCount: widget.board.crossAxisCount,
        itemCount: symbols.length,
        itemBuilder: (context, index) {
          final e = symbols[index];

          return DragTarget<DragItem<CommunicationSymbol>>(onMove: (data) {
            setState(() {
              desiredIndex = index;
            });
          }, onLeave: (data) {
            setState(() {
              desiredIndex = null;
            });
          }, onAcceptWithDetails: (data) {
            if (currentlyDragged == null || desiredIndex == null) return;

            setState(() {
              desiredIndex == null;
              symbols.removeAt(currentlyDragged!.index);
              symbols.insert(desiredIndex!, currentlyDragged!.data);
            });

            ref.read(symbolDaoProvider).moveSymbol(
                newPos: desiredIndex!,
                oldPos: currentlyDragged!.index,
                boardId: widget.board.id);
          }, builder: (context, incoming, __) {
            return LayoutBuilder(builder: (context, constrains) {
              final data = DragItem(index: index, data: e);

              final Offset offset;

              final isNotDragging =
                  currentlyDragged == null || desiredIndex == null;

              if (isNotDragging) {
                offset = const Offset(0, 0);
              } else {
                int min = currentlyDragged!.index;
                int max = desiredIndex!;
                if (min > max) {
                  final tmp = min;
                  min = max;
                  max = tmp;
                }

                final isNotAffected = index < min || index > max;
                final isOnSameTile = currentlyDragged?.index == desiredIndex;
                final isLastInRow = (index + 1) % crossAxisCount == 0;
                final isFirstInRow = (index) % crossAxisCount == 0;

                if (isNotAffected || isOnSameTile) {
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
                        hidden: e.hidden,
                        child: SymbolCard(symbol: e, onTapActions: [
                          SpeakAction(),
                          NavigateToChildBoardAction(),
                          MultiSelectAction(),
                        ])),
                  ));

              return LongPressDraggable(
                data: data,
                maxSimultaneousDrags:
                    ref.watch(areSymbolsSelectedProvider) ? 0 : 1,
                onDragStarted: () {
                  _onLongPress(e, ref);
                  setState(() {
                    currentlyDragged = data;
                    dragStartPosition = Offset.zero;
                  });
                },
                onDragUpdate: (details) {
                  if (dragStartPosition == Offset.zero) {
                    dragStartPosition = details.globalPosition;
                    setState(() {});
                  } else if (!didDraggedSignificantly &&
                      (dragStartPosition - details.globalPosition)
                              .distance
                              .abs() >
                          20) {
                    _onLongPress(e, ref);
                    didDraggedSignificantly = true;
                  }

                  _startAutoScroll(details.localPosition, controller);
                },
                onDragEnd: (_) => setState(() {
                  currentlyDragged = null;
                  dragStartPosition = Offset.zero;
                  didDraggedSignificantly = false;
                }),
                feedback: Material(
                  child: SizedBox(
                      width: constrains.maxWidth,
                      height: constrains.maxHeight.isInfinite
                          ? null
                          : constrains.maxHeight,
                      child: SymbolCard(
                        symbol: e,
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
