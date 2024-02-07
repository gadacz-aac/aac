import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/file_helpers.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aac/src/features/symbols/symbol_settings.dart';
import 'package:isar/isar.dart';

//TODO: make the symbol disappear(/change) from the sentence after the symbol is deleted(/edited). Particularly important when edited!
// TODO since the symbol can be displayed on multiple boards at the same time we have to update all of the boards and not just one with id == boardId

class EditSymbolScreen extends ConsumerStatefulWidget {
  const EditSymbolScreen(
      {super.key, required this.symbol, required this.boardId});

  final CommunicationSymbol symbol;
  final Id boardId;

  @override
  ConsumerState<EditSymbolScreen> createState() => _EditSymbolScreenState();
}

class _EditSymbolScreenState extends ConsumerState<EditSymbolScreen> {
  Future<void> save(
      String path, String label, bool isFolder, int count, int? color) async {
    final manager = ref.read(symbolManagerProvider);

    widget.symbol.label = label;
    widget.symbol.imagePath = path;
    widget.symbol.color = color;

    manager.updateSymbol(
      symbol: widget.symbol,
      parentBoardId: widget.boardId,
      imagePath: await saveImage(path, label),
      createChild: isFolder,
      crossAxisCount: count,
    );
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SymbolSettings(
      passedSymbolName: widget.symbol.label,
      passedImagePath: widget.symbol.imagePath,
      passedSymbolColor: widget.symbol.color,
      passedIsFolder: widget.symbol.childBoard.value != null,
      passedAxisCount: widget.symbol.childBoard.value?.crossAxisCount ??
          2, //TODO: fix later; may cause issues, as the axis count is specified in a few places
      updateSymbolSettings: save,
    );
  }
}
