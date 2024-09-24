import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinSymbolsAction extends ConsumerWidget {
  const PinSymbolsAction({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () async {
          final symbolManager = ref.read(symbolManagerProvider);
          final symbols = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SymbolSearchScreen()));

          if (symbols == null) return;

          symbolManager.pinSymbolsToBoard(symbols, board.id);
        },
        icon: const Icon(Icons.search));
  }
}
