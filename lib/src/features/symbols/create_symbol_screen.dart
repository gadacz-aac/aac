import 'package:aac/src/features/symbols/file_helpers.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:aac/src/features/symbols/symbol_settings.dart';

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({super.key, required this.boardId});

  final Id boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  void submit(String path, String label, bool isFolder, int count) async {
    final manager = ref.read(symbolManagerProvider);

    manager.saveSymbol(
      widget.boardId,
      label: label,
      imagePath: await saveImage(path),
      crossAxisCount: count,
      createChild: isFolder,
    );

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SymbolSettings(updateSymbolSettings: submit);
  }
}
