import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';

class SymbolsGrid extends StatelessWidget {
  const SymbolsGrid({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context) {
    return BaseSymbolsGrid(
      itemBuilder: (context, index) {
        final e = board.symbols.elementAt(index);
        return SymbolCard(
          symbol: e,
          onTapActions: const [SymbolOnTapAction.cd, SymbolOnTapAction.speak],
        );
      },
      itemCount: board.symbols.length,
      crossAxisCount: board.crossAxisCount,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
    );
  }
}
