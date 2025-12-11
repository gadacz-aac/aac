import 'package:aac/src/database/daos/child_communication_symbol_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/popup_board_route.dart';
import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/features/symbols/bin/bin_manager.dart';
import 'package:aac/src/features/symbols/bin/models.dart';
import 'package:aac/src/features/symbols/bin/providers.dart';
import 'package:aac/src/features/symbols/card/symbol_image.dart';
import 'package:aac/src/features/symbols/search/no_search_results.dart';
import 'package:aac/src/shared/ui/bottom_sheet_options.dart';
import 'package:aac/src/shared/ui/show_more_options.dart';
import 'package:flutter/material.dart' hide SelectAction;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinScreenBoard extends ConsumerWidget {
  const BinScreenBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedBoards = ref.watch(deletedBoardsProvider);

    return deletedBoards.when(
      data: (data) {
        if (data.isEmpty) {
          return NoResultsScreen(
              title: "Brak usuniętych tablic",
              subtitle: "Kosz jest pusty",
              isLoading: false);
        }

        return Center(
          child: ListView.builder(
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
      error: (error, stack) => Center(child: Text('Error: $error')),
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
    return BottomSheetOptions(
      children: [
        OptionGroup(
          options: [
            Option(
                onTap: () {
                  Navigator.pushReplacement(context, PopupBoardRoute(e.id));
                },
                icon: Icon(Icons.open_in_new_outlined),
                label: "Zobacz podgląd"),
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
                        title: "Przywróć tablicę i symbole",
                        subtitle: "Wybierz symbole, które chcesz \nprzywrócić",
                        symbols: sym,
                      ), (selected) {
                    ref
                        .read(binManagerProvider)
                        .boardRestoreFromTrash(e.id, selected);
                  });
                },
                icon: Icon(Icons.delete_outlined),
                label: "Przywróć"),
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
                        title: "Usuń tablicę i symbole",
                        subtitle: "Wybierz symbole, które chcesz \nusunąć",
                        symbols: sym,
                      ), (selected) {
                    ref
                        .read(binManagerProvider)
                        .boardDeletePermanently(e.id, selected);
                  });
                },
                icon: Icon(Icons.delete_outlined),
                label: "Usuń na zawsze"),
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
                      "Zatwierdź",
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
        child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            clipBehavior: Clip.hardEdge,
            child: ListView.separated(
                itemCount: symbols.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 0, color: Color(0xFFEFEFEF)),
                itemBuilder: (context, index) {
                  final e = symbols[index];

                  return Material(
                      child: CheckboxListTile(
                    secondary: SymbolImage(
                      e.imagePath,
                      width: 48,
                      height: 48,
                    ),
                    title: Text(e.label),
                    value: selectedMap[e.id] ?? e.isSelected,
                    tileColor: Colors.white,
                    onChanged: (val) {
                      if (val != null) {
                        selectedMap[e.id] = val;
                        setState(() {});
                      }
                    },
                  ));
                })),
      )
    ]);
  }
}
