import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_chip.dart';
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
    final List<Widget> chips;
    final childBoard = ref.watch(boardProvider).value;

    if (childBoard == null) {
      chips = [const LinkNewBoardChip(), const LinkExistingBoardChip()];
    } else {
      chips = [const LinkedBoardChip()];
    }

    return Wrap(
      spacing: 11,
      runSpacing: 8,
      children: chips.toList(),
    );
  }
}
