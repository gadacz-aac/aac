import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/edit_symbol_screen.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditSymbolAction extends ConsumerWidget {
  const EditSymbolAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areSelectedSymbol = ref.watch(areMultipleSymbolsSelected);
    if (areSelectedSymbol) return const SizedBox();

    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      tooltip: "Edytuj",
      onPressed: () async {
        final symbol = ref.read(selectedSymbolsProvider).state.first;
        final boardId = ref.read(boardIdProvider);
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditSymbolScreen(symbol: symbol, boardId: boardId)));
        ref.read(selectedSymbolsProvider).clear();
      },
    );
  }
}
