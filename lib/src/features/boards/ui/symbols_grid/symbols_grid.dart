import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/symbols_grid_with_drag.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';

class SymbolsGrid extends StatefulWidget {
  const SymbolsGrid({super.key, required this.board});

  final Board board;

  @override
  State<SymbolsGrid> createState() => _SymbolsGridState();
}

class _SymbolsGridState extends State<SymbolsGrid> {
  late final List<CommunicationSymbol> symbols;

  @override
  void initState() {
    super.initState();
    symbols =
        getReorderSymbols(widget.board.reorderedSymbols, widget.board.symbols);
  }

  @override
  Widget build(BuildContext context) {
    return BaseSymbolsGrid(
      itemBuilder: (context, index) {
        final e = symbols.elementAt(index);
        return SymbolCard(
          symbol: e,
          onTapActions: const [SymbolOnTapAction.cd, SymbolOnTapAction.speak],
        );
      },
      itemCount: symbols.length,
      crossAxisCount: widget.board.crossAxisCount,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
    );
  }
}
