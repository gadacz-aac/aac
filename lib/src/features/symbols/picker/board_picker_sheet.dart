import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_album_card.dart';
import 'package:aac/src/shared/ui/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Modal sheet for browsing boards and picking one, e.g. as a target board
/// to add existing symbols to. Pops with the selected [Board].
class BoardPickerSheet extends ConsumerStatefulWidget {
  const BoardPickerSheet({super.key});

  @override
  ConsumerState<BoardPickerSheet> createState() => _BoardPickerSheetState();
}

class _BoardPickerSheetState extends ConsumerState<BoardPickerSheet> {
  final controller = TextEditingController();
  String query = "";

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AacSearchField(
              icon: const Icon(Icons.search),
              placeholder: l10n.searchBoards,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
                future: ref
                    .read(boardDaoProvider)
                    .searchBoard(query: query)
                    .map(Board.fromEntity)
                    .get(),
                builder: (context, snapshot) {
                  final results = snapshot.data;

                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (results == null || results.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.noResultsFor(query),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return AlignedGridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final board = results[index];

                      return BoardAlbumCard(
                        name: board.name,
                        boardId: board.id,
                        onTap: () => Navigator.pop(context, board),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
