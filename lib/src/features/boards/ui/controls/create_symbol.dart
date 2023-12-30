import 'package:aac/src/features/boards/ui/controls/control.dart';
import 'package:aac/src/features/symbols/create_symbol_screen.dart';
import 'package:aac/src/features/symbols/randomise_symbol.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class CreateSymbol extends StatelessWidget {
  const CreateSymbol({super.key, required this.boardId});

  final Id boardId;

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: Icons.add,
      backgroundColor: AacColors.mainControlBackground,
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddSymbolMenu(boardId: boardId)));
      },
    );
  }
}

class CreateRandomSymbol extends ConsumerWidget {
  const CreateRandomSymbol({
    super.key,
    required this.boardId,
  });

  final Id boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Control(
      onPressed: () async {
        randomiseSymbol(ref, boardId);
      },
      icon: Icons.shuffle,
    );
  }
}
