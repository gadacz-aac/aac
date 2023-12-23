import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../symbols/ui/symbol_image.dart';
import '../../text_to_speech/provider.dart';

class SentenceBar extends ConsumerWidget {
  const SentenceBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(sentenceNotifierProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 30.0),
      color: AacColors.sentenceBarGrey,
      height: 64.0,
      child: Row(
        children: [
          // IconButton(
          //     onPressed: () {
          //       ref
          //           .read(ttsManagerProvider)
          //           .saySentence(ref.read(sentenceNotifierProvider));
          //     },
          //     icon: const Icon(Icons.play_arrow)),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: symbols
                  .map((symbol) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SymbolImage(
                        symbol.imagePath,
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                      )))
                  .toList(),
            ),
          ),
          // IconButton(
          //     onPressed:
          //         ref.read(sentenceNotifierProvider.notifier).removeLastWord,
          //     icon: const Icon(Icons.backspace)),
          // IconButton(
          //     onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
          //     icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
