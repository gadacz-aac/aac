import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aac/src/features/symbols/symbol_settings.dart';

//TODO: add an option to delete the image
class EditSymbolScreen extends ConsumerStatefulWidget {
  const EditSymbolScreen(
      {super.key, required this.symbol, required this.board});

  final CommunicationSymbol symbol;
  final Board board;

  @override
  ConsumerState<EditSymbolScreen> createState() => _EditSymbolScreenState();
}

class _EditSymbolScreenState extends ConsumerState<EditSymbolScreen> {
  void save(String path, String label, bool isFolder, int count) {
    final manager = ref.read(symbolManagerProvider);

    widget.symbol.label = label;
    widget.symbol.imagePath = path;

    manager.updateSymbol(
      symbol: widget.symbol,
      parentBoard: widget.board,
      createChild: isFolder,
      crossAxisCount: count,
    );
    //TODO: add transformation to file name
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SymbolSettings(
      passedSymbolName: widget.symbol.label,
      passedImagePath: widget.symbol.imagePath,
      passedIsFolder: widget.symbol.childBoard.value != null,
      passedAxisCount: widget.symbol.childBoard.value?.crossAxisCount ??
          2, //TODO: fix later; may cause issues, as the axis count is specified in a few places
      updateSymbolSettings: save,
    );
  }
}
