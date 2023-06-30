import 'dart:io';

import 'package:aac/src/shared/providers.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/create_symbol_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: BoardScreen(
      boardId: 1,
    ));
  }
}

Future<List<String>?> openMenu(BuildContext context) async {
  final result = await Navigator.push(
      context,
      MaterialPageRoute<List<String>>(
          builder: (context) => const AddSymbolMenu()));
  return result;
}

class SymbolsGrid extends ConsumerWidget {
  const SymbolsGrid({super.key, required this.boardId});

  final Id boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(symbolsProvider(boardId));

    return symbols.when(
        data: (data) => Flexible(
              child: GridView.count(
                crossAxisCount: 2,
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

class SymbolImage extends StatelessWidget {
  const SymbolImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Uri.parse(path).isAbsolute
        ? Image.network(
            path,
            width: width,
            height: height,
            fit: fit,
          )
        : Image.file(
            File(path),
            width: width,
            height: height,
            fit: fit,
          );
  }
}

class SymbolCard extends ConsumerWidget {
  const SymbolCard({super.key, required this.symbol});

  final CommunicationSymbol symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () {
          ref.read(ttsManagerProvider).sayWord(symbol.label);
          ref.read(sentenceNotifierProvider.notifier).addWord(symbol);

          if (symbol.childBoard.value != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BoardScreen(
                        title: symbol.label,
                        boardId: symbol.childBoard.value!.id,
                      )),
            );
          }
        },
        child: Column(
          children: [
            Expanded(child: SymbolImage(symbol.imagePath)),
            Text(
              symbol.label,
              style: const TextStyle(fontSize: 20.0),
            )
          ],
        ));
  }
}
