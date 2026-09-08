import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/picker/board_picker_sheet.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:aac/src/features/symbols/symbol_board_association_manager.dart';
import 'package:aac/src/shared/ui/show_more_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Adds the currently selected symbols to a board chosen by browsing boards.
/// Replaces the old pin action that only worked when arriving from a board.
class PickTargetBoardAction extends ConsumerWidget {
  const PickTargetBoardAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return IconButton(
      onPressed: () async {
        final board = await showMoreOptions(
            context, (context) => const BoardPickerSheet());

        if (board == null || !context.mounted) return;

        final selectedSymbols = [...ref.read(selectedSymbolsProvider).state];
        ref.read(selectedSymbolsProvider.notifier).clear();

        await ref
            .read(symbolBoardAssociationManagerProvider)
            .pin(board.id, selectedSymbols);

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              l10n.symbolsAddedToBoard(board.name, selectedSymbols.length)),
        ));
      },
      tooltip: l10n.addExistingSymbol,
      icon: const Icon(Icons.drive_file_move_outline),
    );
  }
}
