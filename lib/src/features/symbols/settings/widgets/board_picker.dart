import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/features/symbols/settings/screens/board_search_screen.dart';
import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_album_card.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_picker.g.dart';

@Riverpod(dependencies: [initialValues])
class BoardNotifier extends _$BoardNotifier {
  @override
  Future<BoardEditModel?> build() {
    final id = ref.watch(initialValuesProvider).childBoardId;

    if (id == null) return Future.value(null);

    return ref
        .watch(boardDaoProvider)
        .selectById(id)
        .map((e) => BoardEditModel(
            name: e.name, columnCount: e.crossAxisCount, id: e.id))
        .getSingle();
  }

  void delete() {
    state = AsyncValue.data(null);
  }

  void set(BoardEditModel? board) {
    state = AsyncValue.data(board);
  }
}

@Dependencies([BoardNotifier])
class BoardPicker extends ConsumerWidget {
  const BoardPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final childBoard = ref.watch(boardProvider).value;

    if (childBoard != null) {
      return LinkedBoardTile(board: childBoard);
    }

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        BoardActionTile(
          icon: Icons.add,
          label: l10n.addNewBoard,
          onTap: () => _openCreateBoard(context, ref),
        ),
        BoardActionTile(
          icon: Icons.search_outlined,
          label: l10n.findExistingBoard,
          onTap: () => _openBoardSearch(context, ref),
        ),
      ],
    );
  }

  Future<void> _openCreateBoard(BuildContext context, WidgetRef ref) async {
    final board = await showModalBottomSheet<BoardEditModel?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const CreateBoardScreen(params: BoardEditModel()),
    );

    if (board == null || !context.mounted) return;
    ref.read(boardProvider.notifier).set(board);
  }

  Future<void> _openBoardSearch(BuildContext context, WidgetRef ref) async {
    final board = await showModalBottomSheet<BoardEditModel?>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      builder: (context) => const BoardSearch(),
    );

    if (board == null || !context.mounted) return;
    ref.read(boardProvider.notifier).set(board);
  }
}

@Dependencies([BoardNotifier])
class LinkedBoardTile extends ConsumerWidget {
  const LinkedBoardTile({
    super.key,
    required this.board,
  });

  final BoardEditModel board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BoardAlbumTile(
      name: board.name,
      boardId: board.id,
      onTap: () => _openEdit(context, ref),
      onDelete: () => ref.read(boardProvider.notifier).delete(),
    );
  }

  Future<void> _openEdit(BuildContext context, WidgetRef ref) async {
    final edited = await showModalBottomSheet<BoardEditModel?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CreateBoardScreen(params: board),
    );

    if (edited == null || !context.mounted) return;
    ref.read(boardProvider.notifier).set(edited);
  }
}
