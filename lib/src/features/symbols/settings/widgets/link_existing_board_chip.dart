import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/settings/screens/board_search_screen.dart';
import 'package:flutter/material.dart';

class LinkExistingBoardChip extends StatelessWidget {
  const LinkExistingBoardChip({
    super.key,
    required this.setChildBoard,
    required this.childBoard,
  });

  final Board? childBoard;
  final void Function(Board?) setChildBoard;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
        avatar: const Icon(Icons.search_outlined),
        onPressed: () {
          showModalBottomSheet<Board?>(
              backgroundColor: Colors.white,
              context: context,
              isDismissible: true,
              builder: (context) => const BoardSearch()).then(setChildBoard);
        },
        label: const Text("Wyszukaj istniejącą"));
  }
}
