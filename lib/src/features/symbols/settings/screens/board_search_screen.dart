import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_album_card.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/ui/search_input.dart';
import 'package:aac/src/shared/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_search_screen.g.dart';

@riverpod
Future<List<Board>> foundBoards(Ref ref) async {
  final query = ref.watch(queryProvider);

  return ref
      .watch(boardDaoProvider)
      .searchBoard(query: query)
      .map(Board.fromEntity)
      .get();
}

class BoardSearch extends ConsumerWidget {
  const BoardSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final results = ref.watch(foundBoardsProvider).value;
    final query = ref.watch(queryProvider);
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO Standarise with Generic Text Field
            AacSearchField(
              icon: const Icon(Icons.search),
              placeholder: l10n.searchBoards,
              onChanged: (value) {
                final debounce = Debouncer(const Duration(milliseconds: 300));
                debounce(() =>
                    ref.read(queryProvider.notifier).update((state) => value));
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ActionChip(
              avatar: const Icon(Icons.add),
              label: Text(l10n.addNewBoard),
              onPressed: () => _createBoard(context),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(l10n.myBoards, style: textTheme.labelLarge),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: results == null
                  ? const Center(child: CircularProgressIndicator())
                  : results.isEmpty
                      ? Center(
                          child: Text(
                            l10n.noResultsFor(query),
                            style: textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : AlignedGridView.count(
                          padding: const EdgeInsets.only(bottom: 20),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final board = results[index];
                            return BoardAlbumCard(
                              name: board.name,
                              boardId: board.id,
                              onTap: () => Navigator.pop(
                                  context, BoardEditModel.fromBoard(board)),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createBoard(BuildContext context) async {
    final board = await showModalBottomSheet<BoardEditModel?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const CreateBoardScreen(params: BoardEditModel()),
    );

    if (board == null || !context.mounted) return;
    Navigator.pop(context, board);
  }
}
