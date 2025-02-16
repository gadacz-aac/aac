import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: make the symbol disappear(/change) from the sentence after the symbol is deleted(/edited). Particularly important when edited!
// TODO since the symbol can be displayed on multiple boards at the same time we have to update all of the boards and not just one with id == boardId

class EditSymbolScreen extends ConsumerStatefulWidget {
  const EditSymbolScreen(
      {super.key, required this.symbol, required this.boardId});

  final CommunicationSymbolOld symbol;
  final int boardId;

  @override
  ConsumerState<EditSymbolScreen> createState() => _EditSymbolScreenState();
}

class _EditSymbolScreenState extends ConsumerState<EditSymbolScreen> {
  Future<void> save(SymbolEditingParams params) async {
    final manager = ref.read(symbolManagerProvider);

    manager.updateSymbol(
        symbol: widget.symbol, parentBoardId: widget.boardId, params: params);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        initialValuesProvider
            .overrideWithValue(SymbolEditingParams.fromSymbol(widget.symbol))
      ],
      child: SymbolSettings(
        updateSymbolSettings: save,
        boardId: widget.boardId,
      ),
    );
  }
}
