import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';

class SymbolCardLabel extends StatelessWidget {
  const SymbolCardLabel({
    super.key,
    required this.labelBgColor,
    required this.symbol,
    required this.textColor,
  });

  final Color labelBgColor;
  final CommunicationSymbol symbol;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AacColors.labelShadow,
              blurRadius: 1,
              spreadRadius: 4,
              offset: Offset(0, 4),
            )
          ],
          color: labelBgColor,
        ),
        child: SymbolCardText(symbol: symbol, textColor: textColor),
      ),
    );
  }
}

class SymbolCardText extends StatelessWidget {
  const SymbolCardText({
    super.key,
    required this.symbol,
    required this.textColor,
  });

  final CommunicationSymbol symbol;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      symbol.label,
      textAlign: TextAlign.center,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: true,
        applyHeightToLastDescent: true,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: textColor,
            height: 1.25,
          ),
    );
  }
}
