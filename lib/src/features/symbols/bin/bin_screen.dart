import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/bin/bin_bar.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bin_screen.g.dart';

@riverpod
Stream<List<CommunicationSymbol>> deletedSymbols(Ref ref) {
  return ref.watch(symbolDaoProvider).watchDeleted();
}

class BinScreen extends ConsumerWidget {
  const BinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedSymbols = ref.watch(deletedSymbolsProvider);

    return Scaffold(
      appBar: const BinAppBar(
        title: 'Kosz',
      ),
      body: Column(
        children: [
          deletedSymbols.when(
            data: (data) {
              return BaseSymbolsGrid(
                itemBuilder: (context, index) {
                  final e = data.elementAt(index);
                  return SymbolCard(
                    symbol: e,
                    onTapActions: [
                      SymbolOnTapAction.speak,
                      SymbolOnTapAction.select,
                      SymbolOnTapAction.multiselect
                    ],
                  );
                },
                itemCount: data.length,
                crossAxisCount: 4,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}
