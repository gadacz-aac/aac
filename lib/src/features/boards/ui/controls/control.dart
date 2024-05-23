import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  const Control({
    super.key,
    this.onPressed,
    required this.icon,
    this.disabled = false,
    this.backgroundColor,
  });

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
