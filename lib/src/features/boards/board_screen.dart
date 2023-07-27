import 'dart:async';

import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:aac/src/features/settings/utils/protective_mode.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';

import '../symbols/create_symbol_screen.dart';
import '../text_to_speech/tts_manager.dart';
import 'model/board.dart';

class BoardScreen extends ConsumerWidget {
  BoardScreen({super.key, this.title = 'dupa', required this.boardId}) {
    _isMainBoard = boardId != 1;
  }

  final String title;
  final Id boardId;
  late final bool _isMainBoard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardProvider(boardId));
    return board.when(
        error: (error, _) => ErrorScreen(error: error.toString()),
        loading: () => Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
        data: (data) {
          if (data == null) {
            return ErrorScreen(
              error: "Board with id $boardId wasn't found",
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              automaticallyImplyLeading: _isMainBoard,
              actions: const [LockButton()],
            ),
            body: Column(
              children: [
                const SentenceBar(),
                SymbolsGrid(
                  board: data,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddSymbolMenu(boardId: boardId)));
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oops..')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/oops-steve-carell.gif',
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            error,
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ]),
      ),
    );
  }
}

class LockButton extends StatefulWidget {
  const LockButton({
    super.key,
  });

  @override
  State<LockButton> createState() => _LockButtonState();
}

class _LockButtonState extends State<LockButton> {
  int _tapLeft = 3;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (_tapLeft == 3) {
            Timer(const Duration(seconds: 3), () {
              _tapLeft = 3;
            });
          }
          _tapLeft -= 1;

          if (_tapLeft == 0) {
            stopProtectiveMode();
            Navigator.popUntil(
                context, (Route<dynamic> predicate) => predicate.isFirst);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Tap $_tapLeft times to leave protective mode")));
          }
        },
        icon: const Icon(Icons.lock));
  }
}

class SymbolsGrid extends StatelessWidget {
  const SymbolsGrid({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
          crossAxisCount: board.crossAxisCount,
          children: board.symbols.map((e) => SymbolCard(symbol: e)).toList()),
    );
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
