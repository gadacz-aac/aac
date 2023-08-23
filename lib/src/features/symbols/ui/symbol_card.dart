import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/features/symbols/edit_symbol_screen.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../boards/model/board.dart';
import '../../text_to_speech/tts_manager.dart';

class SymbolCard extends ConsumerWidget {
  const SymbolCard({super.key, required this.symbol, required this.board});

  final CommunicationSymbol symbol;
  final Board board;

  Future<void> _buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(children: [
          UnpinSymbolDialogOption(symbol: symbol, board: board),
          EditSymbolDialogOption(symbol: symbol, board: board),
          DeleteForeverDialogOption(symbol: symbol, board: board),
        ]);
      },
    );
  }

  void _onLongPress(BuildContext context, WidgetRef ref) {
    if (!ref.read(isParentModeProvider)) return;
    _buildDialog(context);
  }

  void _onTap(BuildContext context, WidgetRef ref) {
    ref.read(ttsManagerProvider).sayWord(symbol.label);
    ref.read(sentenceNotifierProvider.notifier).addWord(symbol);

    if (symbol.childBoard.value != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BoardScreen(
                  title: symbol.label,
                  boardId: symbol.childBoard.value!.id,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onLongPress: () => _onLongPress(context, ref),
        onTap: () => _onTap(context, ref),
        child: Column(
          children: [
            Expanded(
              child: SymbolImage(
                symbol.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              symbol.label,
              style: const TextStyle(fontSize: 20.0),
            )
          ],
        ));
  }
}

class DeleteForeverDialogOption extends ConsumerWidget {
  const DeleteForeverDialogOption({
    super.key,
    required this.symbol,
    required this.board,
  });

  final CommunicationSymbol symbol;
  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbolManager = ref.watch(symbolManagerProvider);
    return ListTile(
        leading: const Icon(Icons.delete_forever),
        title: const Text("Usuń na zawsze"),
        onTap: () {
          Navigator.pop(context);
          showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Usuń na zawsze"),
              content: Text(
                  "Symbol zostanie usunięty z ${symbol.parentBoard.length} tablic"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    symbolManager.deleteSymbol(symbol, board);
                    Navigator.pop(context, true);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        });
  }
}

class EditSymbolDialogOption extends StatelessWidget {
  const EditSymbolDialogOption({
    super.key,
    required this.symbol,
    required this.board,
  });

  final CommunicationSymbol symbol;
  final Board board;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.edit),
      title: const Text("Edytuj"),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditSymbolScreen(symbol: symbol, board: board)));
      },
    );
  }
}

class UnpinSymbolDialogOption extends ConsumerWidget {
  const UnpinSymbolDialogOption({
    super.key,
    required this.symbol,
    required this.board,
  });

  final CommunicationSymbol symbol;
  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
        leading: const Icon(Icons.push_pin_outlined),
        title: const Text("Odepnij"),
        onTap: () {
          ref.read(symbolManagerProvider).unpinSymbolFromBoard(symbol, board);
          Navigator.pop(context);
        });
  }
}
