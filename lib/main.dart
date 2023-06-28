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
      ),
    );
  }
}

class Board extends ConsumerWidget {
  const Board({super.key, this.title = 'dupa', required this.boardId});

  final String title;
  final Id boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(symbolsProvider(boardId));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: symbols.when(
          data: (data) => GridView.count(
                crossAxisCount: 2,
                children: data.map((e) => SymbolCard(symbol: e)).toList(),
              ),
          error: (error, stack) => const Text('Oops..'),
          loading: () => const CircularProgressIndicator()),
      // Button for adding new symbols (aka notes)
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddSymbolMenu()));
      }),
    );
  }
}

class SymbolCard extends StatelessWidget {
  const SymbolCard({super.key, required this.symbol});

  final CommunicationSymbol symbol;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
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
            Expanded(child: _buildImage(symbol.imagePath)),
            Text(
              symbol.label,
              style: const TextStyle(fontSize: 20.0),
            )
          ],
        ));
  }

  Widget _buildImage(String path) {
    return Uri.parse(path).isAbsolute
        ? Image.network(path)
        : Image.file(File(path));
  }
}

class AddSymbolMenu extends StatelessWidget {
  const AddSymbolMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new symbol'),
      ),
      body: Center(
          child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Symbol's name",
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Code for adding new symbol
                },
                child: const Text('Apply'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
