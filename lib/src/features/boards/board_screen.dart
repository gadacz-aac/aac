import 'package:aac/main.dart';
import 'package:aac/src/shared/providers.dart';
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
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var result = await openMenu(context);
        if (result == null) return;
        final manager = await ref.read(symbolManagerProvider.future);
        manager.saveSymbol(boardId, result[1], result[0]);
      }),
    );
  }
}
