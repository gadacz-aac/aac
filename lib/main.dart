import 'dart:io';

import 'package:aac/providers.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';

import 'model/communication_symbol.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Board(
      boardId: 1,
    ));
    // home: TtsScreen());
  }
}

class Board extends ConsumerWidget {
  const Board({super.key, this.title = 'dupa', required this.boardId});

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
          final imageFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          String defaultImage =
              'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

          String imagePath = imageFile != null ? imageFile.path : defaultImage;
          final manager = await ref.read(symbolManagerProvider.future);
          manager.saveSymbol(boardId, WordPair.random().asLowerCase, imagePath);
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
                  builder: (context) => Board(
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
