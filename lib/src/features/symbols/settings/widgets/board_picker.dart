import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/settings/widgets/link_existing_board_chip.dart';
import 'package:aac/src/features/symbols/settings/widgets/link_new_board_chip.dart';
import 'package:flutter/material.dart';

class BoardPicker extends StatelessWidget {
  const BoardPicker(
      {super.key,
      required this.childBoard,
      required this.onCancel,
      required this.setChildBoard});

  final Board? childBoard;
  final void Function(Board?) setChildBoard;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips;

    if (childBoard == null) {
      chips = [
        LinkNewBoardChip(setChildBoard: setChildBoard),
        LinkExistingBoardChip(
            childBoard: childBoard, setChildBoard: setChildBoard)
      ];
    } else {
      chips = [
        InputChip(
          label: Text("${childBoard?.name}"),
          onDeleted: onCancel,
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
