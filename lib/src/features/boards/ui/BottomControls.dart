import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomControls extends ConsumerWidget {
  const BottomControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.fromLTRB(21.0, 0, 21.0, 25.0),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: AacColors.bottomControlsGrey,
          borderRadius: const BorderRadius.all(Radius.elliptical(20.0, 15.0)),
          boxShadow: [
            BoxShadow(
                color: AacColors.shadowPrimary,
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              color: AacColors.bottomCotrolsIcons,
              iconSize: 28.0,
              onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
              icon: const Icon(Icons.delete)),
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                AacColors.bottomCotrolsIcons,
              )),
              onPressed: () {
                ref
                    .read(ttsManagerProvider)
                    .saySentence(ref.read(sentenceNotifierProvider));
              },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label: const Text("MÓW")),
          IconButton(
              color: AacColors.bottomCotrolsIcons,
              iconSize: 28.0,
              onPressed:
                  ref.read(sentenceNotifierProvider.notifier).removeLastWord,
              icon: const Icon(Icons.backspace)),
        ],
      ),
    );
  }
}
