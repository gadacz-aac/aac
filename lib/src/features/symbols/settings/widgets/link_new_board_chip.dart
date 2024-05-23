import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_picker.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinkNewBoardChip extends ConsumerWidget {
  const LinkNewBoardChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      avatar: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<BoardEditingParams?>(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) =>
                    const CreateBoardScreen(params: BoardEditingParams()))
            .then((val) {
          if (val == null) return;
          ref.read(boardNotifierProvider.notifier).set(val);
        });
      },
      label: const Text("Dodaj nową"),
    );
  }
}
