import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/features/symbols/symbol_settings.dart';

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({
    super.key,
    this.imagePath,
    required this.boardId,
  });

  final String? imagePath;
  final Id boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  void submit(SymbolEditingParams params) async {
    final manager = ref.read(symbolManagerProvider);
    manager.saveSymbol(widget.boardId, params);

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SymbolSettings(
        params: SymbolEditingParams(imagePath: widget.imagePath),
        updateSymbolSettings: submit);
  }
}
