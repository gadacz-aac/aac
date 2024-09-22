import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

@immutable
class SymbolGridScrollPossibility {
  final bool canScrollUp;
  final bool canScrollDown;

  const SymbolGridScrollPossibility(this.canScrollUp, this.canScrollDown);
  const SymbolGridScrollPossibility.none() : this(false, false);
  const SymbolGridScrollPossibility.onlyUp() : this(true, false);
  const SymbolGridScrollPossibility.onlyDown() : this(false, true);
  const SymbolGridScrollPossibility.both() : this(true, true);
}

final symbolGridScrollPossibilityProvider =
    StateProvider<SymbolGridScrollPossibility>(
        (ref) => const SymbolGridScrollPossibility.none());

final symbolGridScrollControllerProvider =
    Provider.autoDispose<ScrollController>((ref) {
  late final ScrollController controller;

  void handleScroll() {
    if (controller.position.maxScrollExtent == 0) {
      ref.read(symbolGridScrollPossibilityProvider.notifier).state =
          const SymbolGridScrollPossibility.none();
    } else if (controller.offset == controller.position.maxScrollExtent) {
      ref.read(symbolGridScrollPossibilityProvider.notifier).state =
          const SymbolGridScrollPossibility.onlyUp();
    } else if (controller.offset == 0) {
      ref.read(symbolGridScrollPossibilityProvider.notifier).state =
          const SymbolGridScrollPossibility.onlyDown();
    } else {
      ref.read(symbolGridScrollPossibilityProvider.notifier).state =
          const SymbolGridScrollPossibility.both();
    }
  }

  void handlePositionAttach(ScrollPosition position) {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) => handleScroll());
    position.isScrollingNotifier.addListener(handleScroll);
  }

  void handlePositionDetach(ScrollPosition position) {
    position.isScrollingNotifier.removeListener(handleScroll);
  }

  controller = ScrollController(
      onAttach: handlePositionAttach, onDetach: handlePositionDetach);

  ref.onDispose(() {
    controller.dispose();
  });
  ref.onResume(handleScroll);
  return controller;
});

class SymbolsGrid extends ConsumerStatefulWidget {
  const SymbolsGrid({required this.board, super.key});

  final Board board;
  @override
  ConsumerState<SymbolsGrid> createState() => _SymbolsGridState();
}

class _SymbolsGridState extends ConsumerState<SymbolsGrid> {
  DragItem<CommunicationSymbol>? currentlyDragged;
  int? desiredIndex;
  List<CommunicationSymbol> items = [];

  @override
  void initState() {
    super.initState();
    items = widget.board.reorderedSymbols
        .map((id) => widget.board.symbols.firstWhere((e) => e.id == id))
        .toList();
  }

  @override
  void didUpdateWidget(covariant SymbolsGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    print(oldWidget.board.reorderedSymbols == widget.board.reorderedSymbols);
    if (oldWidget.board.reorderedSymbols != widget.board.reorderedSymbols) {
      items = widget.board.reorderedSymbols
          .map((id) => widget.board.symbols.firstWhere((e) => e.id == id))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(symbolGridScrollControllerProvider);
    final crossAxisCount = widget.board.crossAxisCount;

    return Expanded(
      child: AlignedGridView.count(
          crossAxisCount: crossAxisCount,
          itemCount: items.length,
          padding: const EdgeInsets.all(12.0),
          controller: controller,
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
                items.insert(desiredIndex!, currentlyDragged!.data);
                items.removeAt(currentlyDragged!.index);
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
                        onLongPressActions: const [SymbolOnTapAction.select],
                        onTapActions: const [
                          SymbolOnTapAction.speak,
                          SymbolOnTapAction.cd,
                          SymbolOnTapAction.multiselect
                        ],
                      ),
                    ));

                return Draggable(
                  data: data,
                  onDragStarted: () => setState(() {
                    currentlyDragged = data;
                  }),
                  onDragEnd: (_) => setState(() {
                    currentlyDragged = null;
                  }),
                  feedback: Material(
                    child: IntrinsicHeight(
                      child: SizedBox(
                          width: constrains.maxWidth,
                          // height: constrains.maxHeight.isInfinite
                          //     ? constrains.minHeight
                          //     : constrains.maxHeight,
                          child: child),
                    ),
                  ),
                  childWhenDragging: currentlyDragged?.index == data.index
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                        )
                      : child,
                  child: child,
                );
              });
            });
          }),
    );
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
