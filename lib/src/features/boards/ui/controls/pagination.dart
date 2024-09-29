import 'package:aac/src/features/boards/ui/controls/control.dart';
import 'package:aac/src/features/boards/ui/controls/controls_wrapper.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationControl extends ConsumerWidget {
  const PaginationControl({
    super.key,
    required this.direction,
  });

  final SymbolGridScrollDirection direction;

  void _onPressed(ref) {
    final controller = ref.read(symbolGridScrollControllerProvider);

    final offsetMultiplier =
        direction == SymbolGridScrollDirection.forward ? 1 : -1;
    controller.animateTo(
        controller.offset +
            controller.position.viewportDimension * offsetMultiplier,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SymbolGridScrollPossibility posibility =
        ref.watch(symbolGridScrollPossibilityProvider);

    final bool disabled = direction == SymbolGridScrollDirection.forward &&
            !posibility.canScrollDown ||
        direction == SymbolGridScrollDirection.backward &&
            !posibility.canScrollUp;

    return Control(
        disabled: disabled,
        icon: direction == SymbolGridScrollDirection.forward
            ? Icons.expand_more
            : Icons.expand_less,
        onPressed: () => _onPressed(ref));
  }
}
