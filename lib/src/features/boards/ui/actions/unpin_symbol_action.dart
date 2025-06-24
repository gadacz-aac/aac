import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_board_association_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnpinSymbolAction extends ConsumerWidget {
  const UnpinSymbolAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        icon: const Icon(Icons.push_pin_outlined),
        tooltip: "Odepnij",
        onPressed: () {
          final boardId = ref.read(boardIdProvider);
          // that's what you get for making the state mutable
          final selectedSymbol = [...ref.read(selectedSymbolsProvider).state];

          ref.read(selectedSymbolsProvider).clear();
          ref
              .read(symbolBoardAssociationManagerProvider)
              .unpin(selectedSymbol, boardId);
        });
  }
}
