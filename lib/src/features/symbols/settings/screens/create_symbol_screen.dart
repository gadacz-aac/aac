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

  /// Null when creating outside of a board (e.g. from the search screen) -
  /// the symbol is then saved without pinning it to any board.
  final int? boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  void submit(SymbolEditModel params, [BoardEditModel? boardParams]) async {
    final manager = ref.read(symbolManagerProvider);

    if (widget.boardId == null) {
      manager.createSymbol(params, boardParams);
    } else {
      manager.saveSymbol(widget.boardId!, params, boardParams);
    }

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
