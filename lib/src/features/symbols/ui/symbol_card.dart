import 'dart:async';

import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/features/symbols/edit_symbol_screen.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../boards/model/board.dart';
import '../../text_to_speech/tts_manager.dart';

class SymbolCard extends ConsumerWidget {
  const SymbolCard({super.key, required this.symbol, required this.board});

  final CommunicationSymbol symbol;
  final Board board;
  final bool imageHasBackground = true;

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
    final imagePadding = imageHasBackground
        ? const EdgeInsets.all(0)
        : const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 14.0);

    return InkWell(
        onLongPress: () => _onLongPress(context, ref),
        onTap: () => _onTap(context, ref),
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: AacColors.shadowPrimary,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: AacColors.shadowPrimary,
                  blurRadius: 0,
                  offset: const Offset(0, 0),
                  spreadRadius: 1,
                )
              ],
              color: Colors.white,
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: imagePadding,
                  child: SymbolImage(symbol.imagePath,
                      height: 80, fit: BoxFit.fitHeight),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AacColors.labelShadow,
                                blurRadius: 1,
                                spreadRadius: 4,
                                offset: const Offset(0, 4))
                          ],
                          color: AacColors.nounOrange,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 6.0),
                        // alignment: Alignment.center,
                        child: Text(symbol.label,
                            textAlign: TextAlign.center,
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: true,
                                applyHeightToLastDescent: true,
                                leadingDistribution:
                                    TextLeadingDistribution.even),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .merge(const TextStyle(
                                  // fontSize: 17.0,
                                  color: Colors.white,
                                  height: 1.25,
                                )))))
              ],
            ),
          ),
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
