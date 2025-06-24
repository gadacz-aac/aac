import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_board_association_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinSymbolsAction extends ConsumerWidget {
  const PinSymbolsAction({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () async {
          final symbols = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SymbolSearchScreen()));

          if (symbols == null) return;

          ref
              .read(symbolBoardAssociationManagerProvider)
              .pin(board.id, symbols);
        },
        icon: const Icon(Icons.search));
  }
}
