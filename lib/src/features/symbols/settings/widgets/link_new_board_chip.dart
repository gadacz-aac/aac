import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
import 'package:flutter/material.dart';

class LinkNewBoardChip extends StatelessWidget {
  const LinkNewBoardChip({super.key, required this.setChildBoard});

  final void Function(Board?) setChildBoard;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<Board?>(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => const CreateBoardScreen())
            .then(setChildBoard);
      },
      label: const Text("Dodaj nową"),
    );
  }
}
