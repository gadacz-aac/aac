import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymbolCard extends ConsumerWidget {
  const SymbolCard({super.key, required this.symbol});

  final CommunicationSymbol symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () {
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
        },
        child: Column(
          children: [
            Expanded(child: SymbolImage(symbol.imagePath)),
            Text(
              symbol.label,
              style: const TextStyle(fontSize: 20.0),
            )
          ],
        ));
  }
}
