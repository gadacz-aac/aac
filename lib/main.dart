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

Future<List<String>?> openMenu(BuildContext context) async {
  final result = await Navigator.push(
      context,
      MaterialPageRoute<List<String>>(
          builder: (context) => const AddSymbolMenu()));
  return result;
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
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var result = await openMenu(context);
        if (result == null) return;
        final manager = await ref.read(symbolManagerProvider.future);
        manager.saveSymbol(boardId, result[1], result[0]);
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

class AddSymbolMenu extends StatefulWidget {
  const AddSymbolMenu({super.key});

  @override
  State<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends State<AddSymbolMenu> {
  String _imagePath = "";

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new symbol'),
      ),
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Symbol's name", // Pass it in Navigator.pop
            ),
          ),
          //https://stackoverflow.com/questions/61721809/flutter-call-navigator-pop-inside-async-function
          ElevatedButton(
            onPressed: () async {
              final imageFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              String defaultImage =
                  'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

              _imagePath = imageFile != null ? imageFile.path : defaultImage;
            },
            child: const Text('Select image'), // Pass it in Navigator.pop
          ),

          // Powinno się cofnąć za pomocą: Navigator.pop(context); a potem wykonać coś w podobie do tego:
          // A i część dodawania już do screena nowego note'a powinna być zrealizowana po naciśnięciu apply
          // https://docs.flutter.dev/data-and-backend/state-mgmt/simple
          // https://docs.flutter.dev/cookbook/navigation/returning-data
          // ElevatedButton(
          //   onPressed: () async {
          //     final imageFile =
          //         await ImagePicker().pickImage(source: ImageSource.gallery);

          //     String defaultImage =
          //         'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

          //     String imagePath =
          //         imageFile != null ? imageFile.path : defaultImage;

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Code for adding new symbol
                  List<String> result = [];
                  result.add(_imagePath);
                  result.add(_controller.text);
                  Navigator.pop(context,
                      result); // Return data used for creating new Symbol
                },
                child: const Text('Apply'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Return nothing
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
