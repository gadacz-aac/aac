import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/daos/child_communication_symbol_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/popup_board_route.dart';
import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/features/symbols/bin/bin_manager.dart';
import 'package:aac/src/features/symbols/bin/models.dart';
import 'package:aac/src/features/symbols/bin/providers.dart';
import 'package:aac/src/features/symbols/card/symbol_image.dart';
import 'package:aac/src/features/symbols/search/no_search_results.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/ui/bottom_sheet_options.dart';
import 'package:aac/src/shared/ui/list.dart';
import 'package:aac/src/shared/ui/show_more_options.dart';
import 'package:flutter/material.dart' hide SelectAction;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinScreenBoard extends ConsumerWidget {
  const BinScreenBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final deletedBoards = ref.watch(deletedBoardsProvider);

    return deletedBoards.when(
      data: (data) {
        if (data.isEmpty) {
          return NoResultsScreen(
              title: l10n.noDeletedBoards,
              subtitle: l10n.binEmpty,
              isLoading: false);
        }

        return Padding(
          padding: const EdgeInsets.all(12),
          child: AacList.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final e = data[index];

                return ListTile(
                    title: Text(e.name),
                    trailing: ShowMoreOptions(
                        builder: (context) => DeletedBoardOptions(e: e)));
              }),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          Center(child: Text(l10n.errorPrefix(error.toString()))),
    );
  }
}

class DeletedBoardOptions extends ConsumerWidget {
  const DeletedBoardOptions({
    super.key,
    required this.e,
  });

  final Board e;

  Future<List<SelectableCommunicationSymbol>> getSymbols(WidgetRef ref) async {
    final res =
        await ref.read(childSymbolDaoProvider).findByBoardId(e.id, true);

    return res.map(SelectableCommunicationSymbol.fromSymbol).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return BottomSheetOptions(
      children: [
        OptionGroup(
          options: [
            Option(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PopupBoardRoute(e.id,
                          barrierLabelText: l10n.boardPreview));
                },
                icon: Icon(Icons.open_in_new_outlined),
                label: l10n.viewPreview),
            Option(
                onTap: () async {
                  final sym = await getSymbols(ref);

                  if (!context.mounted) {
                    return;
                  }

                  BoardSymbolPicker.openPicker(
                      context,
                      BoardSymbolPicker(
                        id: e.id,
                        title: l10n.restoreBoardTitle,
                        subtitle: l10n.chooseSymbolsToRestore,
                        symbols: sym,
                      ), (selected) {
                    ref
                        .read(binManagerProvider)
                        .boardRestoreFromTrash(e.id, selected);
                  });
                },
                icon: Icon(Icons.delete_outlined),
                label: l10n.restore),
          ],
        ),
        OptionGroup(
          options: [
            Option(
                onTap: () async {
                  final sym = await getSymbols(ref);

                  if (!context.mounted) {
                    return;
                  }

                  BoardSymbolPicker.openPicker(
                      context,
                      BoardSymbolPicker(
                        id: e.id,
                        title: l10n.deleteBoardTitle,
                        subtitle: l10n.chooseSymbolsToDelete,
                        symbols: sym,
                      ), (selected) {
                    ref
                        .read(binManagerProvider)
                        .boardDeletePermanently(e.id, selected);
                  });
                },
                icon: Icon(Icons.delete_outlined),
                label: l10n.deleteForever),
          ],
        )
      ],
    );
  }
}

// TODO think of a better name
class BoardSymbolPicker extends ConsumerStatefulWidget {
  const BoardSymbolPicker(
      {super.key,
      required this.id,
      required this.title,
      required this.subtitle,
      this.symbols,
      this.subtitle2});

  final int id;
  final String title;
  final String subtitle;
  final String? subtitle2;
  final List<SelectableCommunicationSymbol>? symbols;

  static void openPicker(BuildContext context, BoardSymbolPicker picker,
      Function(Iterable<int> symbolsIds) callback) async {
    final selected =
        await showMoreOptions<Iterable<int>>(context, (_) => picker);

    if (selected != null) {
      callback(selected);
    }
  }

  @override
  ConsumerState<BoardSymbolPicker> createState() => _BoardSymbolPickerState();
}

class _BoardSymbolPickerState extends ConsumerState<BoardSymbolPicker> {
  final Map<int, bool?> selectedMap = {};

  @override
  Widget build(BuildContext context) {
    final symbols = widget.symbols ?? [];

    return BottomSheetOptions(useSingleChildScrollView: false, children: [
      DefaultTextStyle.merge(
        style: TextTheme.of(context).bodyLarge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextTheme.of(context)
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.subtitle,
                      softWrap: true,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.pop(
                      context,
                      widget.symbols
                          ?.where((e) => selectedMap[e.id] ?? e.isSelected)
                          .map((e) => e.id)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      AppLocalizations.of(context).confirm,
                      style: TextTheme.of(context)
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.subtitle2 != null) ...[
              SizedBox(height: 12),
              Text(widget.subtitle2 ?? "")
            ]
          ],
        ),
      ),
      SizedBox(
        height: 12,
      ),
      Expanded(
        child: AacList.builder(
            itemCount: symbols.length,
            itemBuilder: (context, index) {
              final e = symbols[index];

              return CheckboxListTile(
                secondary: SymbolImage(
                  e.imagePath,
                  width: 48,
                  height: 48,
                ),
                title: Text(e.label),
                value: selectedMap[e.id] ?? e.isSelected,
                onChanged: (val) {
                  if (val != null) {
                    selectedMap[e.id] = val;
                    setState(() {});
                  }
                },
              );
            }),
      )
    ]);
  }
}
