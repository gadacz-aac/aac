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

class BaseSymbolsGrid extends ConsumerWidget {
  const BaseSymbolsGrid(
      {super.key,
      required this.itemBuilder,
      required this.itemCount,
      required this.crossAxisCount,
      this.crossAxisSpacing = 0,
      this.mainAxisSpacing = 0});

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final int crossAxisCount;

  final double crossAxisSpacing;
  final double mainAxisSpacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(symbolGridScrollControllerProvider);

    return Expanded(
        child: AlignedGridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              itemCount: itemCount,
              padding: const EdgeInsets.all(12.0),
              controller: controller,
              itemBuilder: itemBuilder,
            ));
  }
}
