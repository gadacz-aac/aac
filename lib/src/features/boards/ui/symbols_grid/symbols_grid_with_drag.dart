import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymbolsGridWithDrag extends ConsumerStatefulWidget {
  const SymbolsGridWithDrag({required this.board, super.key});

  final Board board;
  @override
  ConsumerState<SymbolsGridWithDrag> createState() =>
      _SymbolsGridWithDragState();
}

class _SymbolsGridWithDragState extends ConsumerState<SymbolsGridWithDrag> {
  DragItem<CommunicationSymbol>? currentlyDragged;
  int? desiredIndex;
  List<CommunicationSymbol> items = [];
  Offset dragStartPosition = Offset.zero;
  bool didDraggedSignificantly = false;

  @override
  void initState() {
    super.initState();
    items = widget.board.reorderedSymbols
        .map((id) => widget.board.symbols.firstWhere((e) => e.id == id))
        .toList();
  }

  @override
  void didUpdateWidget(covariant SymbolsGridWithDrag oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.board.symbols.length != widget.board.symbols.length) {
      items = widget.board.reorderedSymbols
          .map((id) => widget.board.symbols.firstWhere((e) => e.id == id))
          .toList();
    }
  }

  void _onLongPress(CommunicationSymbol symbol, WidgetRef ref) {
    if (ref.read(isParentModeProvider)) {
      ref.read(selectedSymbolsProvider).toggle(symbol);
    }
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = widget.board.crossAxisCount;

    return BaseSymbolsGrid(
        crossAxisCount: widget.board.crossAxisCount,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final e = items[index];

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
              items.removeAt(currentlyDragged!.index);
              items.insert(desiredIndex!, currentlyDragged!.data);
            });

            final isar = ref.read(isarProvider);
            final reorderedSymbols = [...widget.board.reorderedSymbols];
            reorderedSymbols.removeAt(currentlyDragged!.index);
            reorderedSymbols.insert(desiredIndex!, currentlyDragged!.data.id);

            isar.writeTxn(() async {
              final board = await isar.boards.get(widget.board.id);
              if (board == null) return;

              board.reorderedSymbols = [...reorderedSymbols];
              isar.boards.put(board);
            });
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
                    child: SymbolCard(
                      symbol: e,
                      onTapActions: const [
                        SymbolOnTapAction.speak,
                        SymbolOnTapAction.cd,
                        SymbolOnTapAction.multiselect
                      ],
                    ),
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
                  } else if (!didDraggedSignificantly &&
                      (dragStartPosition - details.globalPosition)
                              .distance
                              .abs() >
                          20) {
                    _onLongPress(e, ref);
                    didDraggedSignificantly = true;
                  }
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
                    visible: currentlyDragged?.index != data.index,
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
