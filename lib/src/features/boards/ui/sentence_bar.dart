import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../text_to_speech/provider.dart';

class SentenceBar extends ConsumerWidget {
  const SentenceBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(sentenceNotifierProvider);
    return Container(
      height: 94,
      color: AacColors.sentenceBarGrey,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                ref
                    .read(ttsManagerProvider)
                    .saySentence(ref.read(sentenceNotifierProvider));
              },
              icon: const Icon(Icons.play_arrow)),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children:
                      symbols.map((e) => SentenceSymbol(symbol: e)).toList()),
            ),
          ),
          IconButton(
              onPressed:
                  ref.read(sentenceNotifierProvider.notifier).removeLastWord,
              icon: const Icon(Icons.backspace)),
          IconButton(
              onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}

class SentenceSymbol extends StatelessWidget {
  const SentenceSymbol({super.key, required this.symbol});

  final CommunicationSymbolDto symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0,
      height: 62.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SymbolImage(symbol.imagePath, height: 48.0),
            Flexible(
              child: Text(
                symbol.label,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            )
          ]),
    );
  }
}
