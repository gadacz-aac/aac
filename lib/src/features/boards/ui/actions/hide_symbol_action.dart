import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_board_association_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HideSymbolAction extends ConsumerWidget {
  const HideSymbolAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areSelectedSymbol = ref.watch(areMultipleSymbolsSelected);
    if (areSelectedSymbol) return const SizedBox();

    return IconButton(
        onPressed: () async {
          // mutable state is the real devil, and i called them crazy
          final symbolId = ref.read(selectedSymbolsProvider).state.first.id;
          final boardId = ref.read(boardIdProvider);

          await ref
              .read(symbolBoardAssociationManagerProvider)
              .toggleVisiblity(symbolId, boardId);

          ref.read(selectedSymbolsProvider).clear();
        },
        icon: const Icon(Icons.visibility_rounded));
  }
}
