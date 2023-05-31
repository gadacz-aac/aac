import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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

class Board extends StatefulWidget {
  const Board({super.key, this.title = 'dupa'});

  final String title;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<String> words = ["stringi", "bokserki", "majtki z koronką"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: words.map((e) {
          return MyCard(
            text: e,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final String wordPair = WordPair.random().asLowerCase;

            words.add(wordPair);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Board(
                      title: text,
                    )),
          );
        },
        child: GridTile(
          footer: GridTileBar(
            title: Text(text),
            backgroundColor: Colors.black45,
          ),
          child: Image.network(
              'https://cdn.discordapp.com/attachments/1108422948970319886/1113419609387843655/anti_kinder.png'),
        ));
    // child: Center(child: Text(text)));
  }
}
