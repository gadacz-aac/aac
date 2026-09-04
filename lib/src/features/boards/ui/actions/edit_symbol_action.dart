import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:aac/src/features/symbols/settings/screens/edit_symbol_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the edit symbol screen for the currently selected symbol.
///
/// [boardId] is optional - it is only needed to pin an existing duplicated
/// symbol to the board the edit was started from (e.g. the board screen).
/// From contexts outside of a board, like the search screen, it stays null.
class EditSymbolAction extends ConsumerWidget {
  const EditSymbolAction({
    super.key,
    this.boardId,
  });

  final int? boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areSelectedSymbol = ref.watch(areMultipleSymbolsSelected);
    if (areSelectedSymbol) return const SizedBox();

    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      tooltip: AppLocalizations.of(context).edit,
      onPressed: () async {
        final symbol = ref.read(selectedSymbolsProvider).state.first;
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditSymbolScreen(symbol: symbol, boardId: boardId)));
        ref.read(selectedSymbolsProvider).clear();
      },
    );
  }
}
