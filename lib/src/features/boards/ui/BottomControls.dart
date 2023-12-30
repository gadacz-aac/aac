import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/shared/colors.dart';

class BottomControls extends ConsumerWidget {
  const BottomControls({super.key, required this.direction});
  final Axis direction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const decoration =
        BoxDecoration(color: AacColors.bottomControlsGrey, boxShadow: [
      BoxShadow(
          color: AacColors.shadowPrimary,
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0)
    ]);

    final padding = direction == Axis.horizontal
        ? const EdgeInsets.all(20.0)
        : const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
    return Container(
      padding: padding,
      decoration: direction == Axis.horizontal ? decoration : null,
      child: Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child:
                PaginationControl(direction: SymbolGridScrollDirection.forward),
          ),
          Gap(9.0, direction),
          const Expanded(
            child: PaginationControl(
              direction: SymbolGridScrollDirection.backward,
            ),
          ),
          Gap(9.0, direction),
          Expanded(
            child: Control(
              icon: Icons.backspace_outlined,
              onPressed:
                  ref.read(sentenceNotifierProvider.notifier).removeLastWord,
            ),
          ),
          Gap(9.0, direction),
          Expanded(
            child: Control(
              icon: Icons.delete_outlined,
              backgroundColor: AacColors.controlBackgroundAttentionSucker,
              onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
            ),
          ),
        ],
      ),
    );
  }
}

class Gap extends StatelessWidget {
  const Gap(
    this.size,
    this.direction, {
    Key? key,
  }) : super(key: key);

  final double size;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return SizedBox(
        width: size,
      );
    }
    return SizedBox(
      height: size,
    );
  }
}

enum SymbolGridScrollDirection { forward, backward }

class PaginationControl extends ConsumerWidget {
  const PaginationControl({
    Key? key,
    required this.direction,
  }) : super(key: key);

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

class Control extends StatelessWidget {
  const Control({
    Key? key,
    this.onPressed,
    required this.icon,
    this.disabled = false,
    this.backgroundColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final IconData icon;
  final bool disabled;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    if (disabled) {
      backgroundColor = AacColors.controlBackgroundDisabled;
    } else if (this.backgroundColor == null) {
      backgroundColor = AacColors.controlBackground;
    } else {
      backgroundColor = this.backgroundColor!;
    }

    return ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backgroundColor),
            iconSize: const MaterialStatePropertyAll(24.0),
            iconColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)))),
        child: Icon(icon));
  }
}
