import 'dart:math' as math;

import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'symbol_card.dart';

class ListSymbolCard extends SymbolCard {
  const ListSymbolCard({
    super.key,
    required super.symbol,
    super.onTapActions = const [],
    super.onLongPressActions = const [],
  }) : super(isListEl: true);
  
  @override
  Widget buildChild(BuildContext context, WidgetRef ref, Color bgColor, Color textColor, EdgeInsets imagePadding, {bool isExpanded = false}) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 40.0),
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Center(
                    child: SymbolImage(symbol.imagePath),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    symbol.label,
                    style: const TextStyle(color: Colors.black),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 40.0,
            decoration: BoxDecoration(
              color: bgColor,
            ),
            child: _hasChildSymbols()
              ? _triangleIcon(isExpanded, textColor)
              : null,
          ),
        ),
      ],
    );
  }

  bool _hasChildSymbols() {
    return symbol.childBoard.value != null;
  }

  Widget _triangleIcon(bool isExpanded, Color textColor) {
    return Transform.rotate(
      angle: isExpanded ? math.pi/2 : 0, // pi/2: down, 0: right
      child: Icon(
        Icons.play_arrow,
        size: 20.0,
        color: textColor,
      ),
    );
  }
}