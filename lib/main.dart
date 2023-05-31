import 'package:aac/text_to_speech.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'model/note.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: Board(),
      home: Board(),
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key, this.title = 'dupa'});

  final String title;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TtsScreen()));
              },
              icon: const Icon(Icons.set_meal))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: notes.map((e) {
          return MyCard(
            note: e,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            final String wordPair = WordPair.random().asLowerCase;
            Note note = Note(text: wordPair, image: wordPair);
            notes.add(note);
          });
          // final image =
          //     await ImagePicker().pickImage(source: ImageSource.gallery);
          // if (image == null) return;
          // debugPrint(image.path);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Board(
                      title: note.text,
                    )),
          );
        },
        child: GridTile(
          footer: GridTileBar(
            title: Text(note.text),
            backgroundColor: Colors.black45,
          ),
          child: Image.network(
              'https://cdn.discordapp.com/attachments/1108422948970319886/1113419609387843655/anti_kinder.png'),
        ));
    // child: Center(child: Text(text)));
  }
}
