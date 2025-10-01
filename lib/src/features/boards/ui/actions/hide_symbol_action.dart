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

    final symbolId = ref.watch(selectedSymbolsProvider).state.first.id;
    final boardId = ref.watch(boardIdProvider);
    final isVisible = ref
        .watch(symbolBoardAssociationManagerProvider)
        .watchIsVisible(symbolId, boardId);

    return IconButton(
        onPressed: () async {
          await ref
              .read(symbolBoardAssociationManagerProvider)
              .toggleVisiblity(symbolId, boardId);

          ref.read(selectedSymbolsProvider).clear();
        },
        icon: StreamBuilder(
            initialData: false,
            stream: isVisible,
            builder: (context, snapshot) {
              final showIsVisible = snapshot.hasData && snapshot.data!;

              return Icon(showIsVisible
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded);
            }));
  }
}
