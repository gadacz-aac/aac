import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({
    super.key,
    this.imagePath,
    required this.boardId,
  });

  final String? imagePath;
  final int boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  void submit(SymbolEditModel params, [BoardEditModel? boardParams]) async {
    final manager = ref.read(symbolManagerProvider);
    manager.saveSymbol(widget.boardId, params, boardParams);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        initialValuesProvider.overrideWithValue(
          SymbolEditModel(imagePath: widget.imagePath),
        )
      ],
      child:
          SymbolSettings(updateSymbolSettings: submit, boardId: widget.boardId),
    );
  }
}
