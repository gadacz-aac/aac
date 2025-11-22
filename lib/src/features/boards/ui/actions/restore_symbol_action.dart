import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestoreSymbolAction extends ConsumerWidget {
  const RestoreSymbolAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.restore),
      tooltip: "Przywróć",
      onPressed: () {
        final symbolManager = ref.read(symbolManagerProvider);
        final selectedSymbols = [...ref.read(selectedSymbolsProvider).state];
        ref.read(selectedSymbolsProvider).clear();

        symbolManager.restoreSymbols(selectedSymbols);
      },
    );
  }
}
