import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoveSymbolToBinAction extends ConsumerWidget {
  const MoveSymbolToBinAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSymbols = ref.watch(selectedSymbolsProvider).state;

    return IconButton(
      icon: const Icon(Icons.delete_outline),
      tooltip: "Usuń",
      onPressed: () {
        final symbols = [...selectedSymbols];
        ref.read(selectedSymbolsProvider).clear();

        ref.read(symbolManagerProvider).moveSymbolToBin(symbols);
      },
    );
  }
}
