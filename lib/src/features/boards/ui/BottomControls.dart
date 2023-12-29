import 'package:aac/src/features/boards/board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/shared/colors.dart';

class BottomControls extends ConsumerWidget {
  const BottomControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration:
          const BoxDecoration(color: AacColors.bottomControlsGrey, boxShadow: [
        BoxShadow(
            color: AacColors.shadowPrimary,
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PaginationControl(direction: SymbolGridScrollDirection.forward),
          const SizedBox(width: 9.0),
          const PaginationControl(
            direction: SymbolGridScrollDirection.backward,
          ),
          const SizedBox(width: 9.0),
          Control(
            icon: Icons.backspace_outlined,
            onPressed:
                ref.read(sentenceNotifierProvider.notifier).removeLastWord,
          ),
          const SizedBox(width: 9.0),
          Control(
            icon: Icons.delete_outlined,
            backgroundColor: AacColors.controlBackgroundAttentionSucker,
            onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
          ),
        ],
      ),
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
    SymbolGridScrollPosition? position =
        ref.watch(symbolGridScrollPositionProvider);
    final bool disabled = direction == SymbolGridScrollDirection.forward &&
            position == SymbolGridScrollPosition.bottom ||
        direction == SymbolGridScrollDirection.backward &&
            position == SymbolGridScrollPosition.top;

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

    return Expanded(
      child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(backgroundColor),
              iconSize: const MaterialStatePropertyAll(24.0),
              iconColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)))),
          child: Icon(icon)),
    );
  }
}
