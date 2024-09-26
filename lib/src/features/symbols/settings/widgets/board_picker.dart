import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
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
      chips = [const LinkedBoardChip()];
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

class LinkedBoardChip extends ConsumerWidget {
  const LinkedBoardChip({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childBoard = ref.watch(boardNotifierProvider);
    if (childBoard == null) return const SizedBox();

    return InputChip(
        label: Text(childBoard.name),
        onDeleted: ref.read(boardNotifierProvider.notifier).delete,
        onPressed: () => showModalBottomSheet<BoardEditingParams?>(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) => CreateBoardScreen(params: childBoard))
                .then((val) {
              if (val == null) return;
              ref.read(boardNotifierProvider.notifier).set(val);
            }));
  }
}
