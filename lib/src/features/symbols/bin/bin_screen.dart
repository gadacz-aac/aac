import 'package:aac/src/features/symbols/bin/bin_bar.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/features/symbols/ui/list_symbol_card.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//MOZE BUILD JESLI SYMBOL MA DZIECI - TAK SAMO W SEARCH TRZRBA BUDOWAC NA NOWO

//TODO fix grid display
//TODO permanently delete after 30 days
//TODOpo pierwszym włączeniu nie można nic zaznaczac w koszu (dopiero po wejsciu w boards i powrocie do kosza)


class BinScreen extends ConsumerWidget {
  const BinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSymbolsAsync = ref.watch(symbolsProvider);
    return Scaffold(
      appBar: const BinAppBar(
        title: 'Kosz',
      ),
      body: allSymbolsAsync.when(
        data: (allSymbols) {
          final folders = allSymbols
            .where((symbol) => symbol.isDeleted && symbol.childBoard.value != null)
            .toList();
          final folderChildBoardIds = folders
            .map((folder) => folder.childBoard.value?.id)
            .where((id) => id != null)
            .toSet();
          final nonFolderSymbols = allSymbols
            .where((symbol) {
              final isDeletedSymbol = symbol.isDeleted;
              final hasNoChildBoard = symbol.childBoard.value == null;

              final isChildOfFolder = symbol.parentBoard.any((parentBoardLink) { //check if any parent is a folder
                final parentBoardId = parentBoardLink.id;
                return folderChildBoardIds.contains(parentBoardId);
              });
              return isDeletedSymbol && hasNoChildBoard && !isChildOfFolder;
            })
            .toList();

          return ListView(
            children: [
              // Display folders first
              ...folders.map((folderSymbol) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    child: SymbolListTile(
                      symbol: folderSymbol,
                      onLongPressActions: const [SymbolOnTapAction.select],
                      onTapActions: const [
                        SymbolOnTapAction.speak,
                        SymbolOnTapAction.multiselect,
                        SymbolOnTapAction.listChild,
                      ],
                    ),
                  )),
              ...nonFolderSymbols.map((symbol) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                    child: SymbolListTile(
                      symbol: symbol,
                      onLongPressActions: const [SymbolOnTapAction.select],
                      onTapActions: const [
                        SymbolOnTapAction.speak,
                        SymbolOnTapAction.multiselect,
                      ],
                    ),
                  )),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
