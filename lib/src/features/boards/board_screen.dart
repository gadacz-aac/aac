import 'package:aac/main.dart';
import 'package:aac/src/features/boards/provider.dart';
import 'package:aac/src/features/symbols/provider.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key, this.title = 'dupa', required this.boardId});

  final String title;
  final Id boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          const SentenceBar(),
          SymbolsGrid(
            boardId: boardId,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await openMenu(context);
          if (result == null) return;
          final manager = await ref.read(symbolManagerProvider.future);
          manager.saveSymbol(boardId,
              label: result[1],
              imagePath: result[0],
              crossAxisCount: result[2]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SymbolsGrid extends ConsumerWidget {
  const SymbolsGrid({super.key, required this.boardId});

  final Id boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(symbolsProvider(boardId));
    final crossAxisCount =
        ref.watch(boardCrossAxisCountProvider(boardId)).valueOrNull;

    return symbols.when(
        data: (data) => Flexible(
              child: GridView.count(
                crossAxisCount: crossAxisCount ?? 2,
                children: data.map((e) => SymbolCard(symbol: e)).toList(),
              ),
            ),
        error: (error, stack) => const Text('Oops..'),
        loading: () => const CircularProgressIndicator());
  }
}

class SentenceBar extends ConsumerWidget {
  const SentenceBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(sentenceNotifierProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 64.0,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                ref
                    .read(ttsManagerProvider)
                    .saySentence(ref.read(sentenceNotifierProvider));
              },
              icon: const Icon(Icons.play_arrow)),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: symbols
                  .map((symbol) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SymbolImage(
                        symbol.imagePath,
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                      )))
                  .toList(),
            ),
          ),
          IconButton(
              onPressed:
                  ref.read(sentenceNotifierProvider.notifier).removeLastWord,
              icon: const Icon(Icons.backspace)),
          IconButton(
              onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
