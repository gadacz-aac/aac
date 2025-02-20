import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/settings/screens/create_symbol_screen.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateSymbol extends ConsumerWidget {
  const CreateSymbol({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
        backgroundColor: AacColors.mainControlBackground,
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageCherryPicker()))
              .then((imagePath) {
            if (imagePath == null) {
              return;
            }

            if (!context.mounted) return;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddSymbolMenu(
                        imagePath: imagePath,
                        boardId: ref.read(boardIdProvider))));
          });
        },
        child: const Icon(
          Icons.add_box_outlined,
          color: AacColors.noColorWhite,
        ));
  }
}

