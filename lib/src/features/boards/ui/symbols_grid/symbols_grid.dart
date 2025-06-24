import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymbolsGrid extends ConsumerWidget {
  final Board board;

  const SymbolsGrid({super.key, required this.board});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(childSymbolProvider(board.id)).valueOrNull;

    if (symbols == null) return SizedBox();

    return BaseSymbolsGrid(
      itemBuilder: (context, index) {
        final e = symbols.elementAt(index);
        return SymbolCard(
          symbol: e,
          onTapActions: const [SymbolOnTapAction.cd, SymbolOnTapAction.speak],
        );
      },
      itemCount: symbols.length,
      crossAxisCount: board.crossAxisCount,
      mainAxisSpacing: 12.0,
      crossAxisSpacing: 12.0,
    );
  }
}
