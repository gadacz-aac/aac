import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aac/src/shared/colors.dart';

class ControlsWrapper extends ConsumerWidget {
  const ControlsWrapper(
      {super.key, this.direction = Axis.horizontal, required this.children});
  final Axis direction;
  final List<Widget> children;

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
            children: children
                .expand((e) => [
                      Expanded(
                        child: e,
                      ),
                      Gap(9.0, direction)
                    ])
                .toList()
              ..removeLast()));
  }
}

class Gap extends StatelessWidget {
  const Gap(
    this.size,
    this.direction, {
    super.key,
  });

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
