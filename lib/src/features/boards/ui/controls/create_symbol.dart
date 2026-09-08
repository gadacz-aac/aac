import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/features/symbols/picker/symbol_picker_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/settings/screens/create_symbol_screen.dart';
import 'package:aac/src/features/symbols/symbol_board_association_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/ui/bottom_sheet_options.dart';
import 'package:aac/src/shared/ui/show_more_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateSymbol extends ConsumerWidget {
  const CreateSymbol({super.key});

  void _openCreateSymbolFlow(BuildContext context, int boardId) {
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
              builder: (context) =>
                  AddSymbolMenu(imagePath: imagePath, boardId: boardId)));
    });
  }

  Future<void> _openSymbolPicker(BuildContext context, WidgetRef ref) async {
    final selected = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SymbolPickerScreen()));

    if (selected == null || selected.isEmpty) return;

    await ref
        .read(symbolBoardAssociationManagerProvider)
        .pin(ref.read(boardIdProvider), selected);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FloatingActionButton(
        backgroundColor: AacColors.mainControlBackground,
        onPressed: () async {
          final parentContext = context;

          await showMoreOptions(
              context,
              (sheetContext) => BottomSheetOptions(
                    children: [
                      OptionGroup(options: [
                        Option(
                            onTap: () {
                              Navigator.pop(sheetContext);
                              _openCreateSymbolFlow(
                                  parentContext, ref.read(boardIdProvider));
                            },
                            icon: const Icon(Icons.add_box_outlined),
                            label: l10n.addSymbol),
                        Option(
                            onTap: () {
                              Navigator.pop(sheetContext);
                              _openSymbolPicker(parentContext, ref);
                            },
                            icon: const Icon(Icons.search),
                            label: l10n.addExistingSymbol),
                      ]),
                    ],
                  ));
        },
        child: const Icon(
          Icons.add_box_outlined,
          color: AacColors.noColorWhite,
        ));
  }
}
