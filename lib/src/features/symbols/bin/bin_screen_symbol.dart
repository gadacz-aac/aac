import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/bin/providers.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:aac/src/features/symbols/search/no_search_results.dart';
import 'package:flutter/material.dart' hide SelectAction;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinScreenSymbol extends ConsumerWidget {
  const BinScreenSymbol({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedSymbols = ref.watch(deletedSymbolsProvider);

    return ProviderScope(
      overrides: [symbolGridScrollControllerProvider],
      child: deletedSymbols.when(
        data: (data) {
          if (data.isEmpty) {
            return NoResultsScreen(
                title: "Brak usuniętych symboli",
                subtitle: "Kosz jest pusty",
                isLoading: false);
          }

          return Column(
            children: [
              BaseSymbolsGrid(
                itemBuilder: (context, index) {
                  final e = data.elementAt(index);
                  return SymbolCard(
                    symbol: e,
                    onTapActions: [
                      SymbolSelectAction(),
                    ],
                  );
                },
                itemCount: data.length,
                crossAxisCount: 4,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
