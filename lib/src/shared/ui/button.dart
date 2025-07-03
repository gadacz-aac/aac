import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  disabled,
  danger,
  noBackground,
}

class AacButton extends StatelessWidget {
  const AacButton({
    super.key,
    this.onPressed,
    required this.child,
    this.type = ButtonType.primary,
  }) : disabled = ButtonType.disabled == type;

  final VoidCallback? onPressed;
  final Widget child;
  final bool disabled;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    var (backgroundColor, foregroundColor) = switch (type) {
      ButtonType.primary => (AacColors.mainControlBackground, Colors.white),
      ButtonType.danger => (
          AacColors.controlBackgroundAttentionSucker,
          Colors.white
        ),
      ButtonType.secondary => (AacColors.controlBackground, Colors.white),
      ButtonType.noBackground => (Colors.transparent, Colors.black),
      ButtonType.disabled => (null, null),
    };

    return ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
            // when this wasn't set transperent background was actually grey
            // https://github.com/flutter/flutter/issues/95793
            elevation: const WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(backgroundColor),
            foregroundColor: WidgetStatePropertyAll(foregroundColor),
            iconSize: const WidgetStatePropertyAll(24.0),
            iconColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)))),
        child: child);
  }
}
