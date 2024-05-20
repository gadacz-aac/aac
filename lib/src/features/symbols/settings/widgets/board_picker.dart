import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/settings/widgets/link_existing_board_chip.dart';
import 'package:aac/src/features/symbols/settings/widgets/link_new_board_chip.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_picker.g.dart';

@Riverpod(dependencies: [initialValues])
class BoardNotifier extends _$BoardNotifier {
  @override
  BoardEditingParams? build() {
    return ref.watch(initialValuesProvider).childBoard;
  }

  void delete() {
    state = null;
  }

  void set(BoardEditingParams? board) {
    state = board;
  }
}

class BoardPicker extends ConsumerWidget {
  const BoardPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> chips;
    final childBoard = ref.watch(boardNotifierProvider);

    if (childBoard == null) {
      chips = [const LinkNewBoardChip(), const LinkExistingBoardChip()];
    } else {
      chips = [
        InputChip(
          label: Text("${childBoard.name}"),
          onDeleted: ref.read(boardNotifierProvider.notifier).delete,
        )
      ];
    }

    return Row(
      children: chips
          .expand((element) => [
                element,
                const SizedBox(
                  width: 11,
                )
              ])
          .toList(),
    );
  }
}
