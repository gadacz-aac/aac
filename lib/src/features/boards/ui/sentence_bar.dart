import 'package:aac/src/features/symbols/ui/symbol_image.dart';
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
      color: AacColors.sentenceBarGrey,
      height: 94,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: symbols.map((e) => SentenceSymbol(symbol: e)).toList()),
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
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SymbolImage(symbol.imagePath, height: 48.0),
            const SizedBox(
              height: 4.0,
            ),
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
