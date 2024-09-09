import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'symbol_card.dart';

class GridSymbolCard extends SymbolCard {
  const GridSymbolCard({super.key, required super.symbol, super.onTapActions = const [], super.onLongPressActions = const []}) : super(isListEl: true);

  @override
  Widget buildChild(BuildContext context, WidgetRef ref, Color bgColor, Color textColor, EdgeInsets imagePadding, {bool isExpanded = false}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: imagePadding,
          child: SymbolImage(symbol.imagePath, height: 80, fit: BoxFit.fitHeight),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AacColors.labelShadow,
                  blurRadius: 1,
                  spreadRadius: 4,
                  offset: Offset(0, 4)
                )
              ],
              color: bgColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
            child: Text(
              symbol.label,
              textAlign: TextAlign.center,
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.even),
              style: Theme.of(context).textTheme.bodySmall!.merge(TextStyle(
                color: textColor,
                height: 1.25,
              )),
            ),
          ),
        )
      ],
    );
  }
}