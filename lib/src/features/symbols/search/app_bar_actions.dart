import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackAction extends ConsumerWidget {
  const BackAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
    );
  }
}

class CancelAction extends ConsumerWidget {
  const CancelAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () => ref.read(selectedSymbolsProvider.notifier).clear(),
        icon: const Icon(Icons.close));
  }
}

class PinSelectedSymbolAction extends ConsumerWidget {
  const PinSelectedSymbolAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () {
          // mutable state is the real devil, and i called them crazy
          final selectedSymbols = [...ref.read(selectedSymbolsProvider).state];
          ref.read(selectedSymbolsProvider.notifier).clear();
          Navigator.pop(context, selectedSymbols);
        },
        icon: const Icon(Icons.push_pin));
  }
}
