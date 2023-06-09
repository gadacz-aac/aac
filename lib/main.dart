import 'dart:io';

import 'package:aac/providers.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'model/communication_symbol.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Board(),
    );
  }
}

// class Board extends StatefulWidget {
//   const Board({super.key, this.title = 'dupa'});

//   final String title;

//   @override
//   State<Board> createState() => _BoardState();
// }

// class _BoardState extends State<Board> {
//   final List<Note> notes = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const TtsScreen()));
//               },
//               icon: const Icon(Icons.set_meal))
//         ],
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         children: notes.map((e) {
//           return SymbolCard(
//             note: e,
//           );
//         }).toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final imageFile =
//               await ImagePicker().pickImage(source: ImageSource.gallery);

//           String defaultImage =
//               'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

//           String image = imageFile != null ? imageFile.path : defaultImage;
//           debugPrint(image);
//           setState(() {
//             final String wordPair = WordPair.random().asLowerCase;
//             Note note = Note(text: wordPair, image: image);
//             notes.add(note);
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

class Board extends ConsumerWidget {
  const Board({super.key, this.title = 'dupa'});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(symbolsProvider);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imageFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);

          String defaultImage =
              'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

          String imagePath = imageFile != null ? imageFile.path : defaultImage;
          final manager = await ref.read(symbolManagerProvider.future);
          manager.saveSymbol(WordPair.random().asLowerCase, imagePath);
        },
        child: const Icon(Icons.add),
      ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Board(title: symbol.label)),
          );
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
