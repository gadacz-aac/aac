import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteForeverAction extends ConsumerWidget {
  const DeleteForeverAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSymbols = ref.watch(selectedSymbolsProvider).state;

    return IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: "Usuń na zawsze",
        onPressed: () {
          showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Usuń na zawsze"),
              content:
                  const Text("Czy jesteś pewien? Operacji nie da się odwrócić"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Anuluj'),
                ),
                TextButton(
                  onPressed: () {
                    final symbolManager = ref.watch(symbolManagerProvider);
                    final boardId = ref.watch(boardIdProvider);
                    // state is mutable
                    final symbols = [...selectedSymbols];
                    ref.read(selectedSymbolsProvider).clear();
                    symbolManager.deleteSymbol(symbols, boardId);
                    Navigator.pop(context);
                  },
                  child: const Text('Usuń'),
                ),
              ],
            ),
          );
        });
  }
}
