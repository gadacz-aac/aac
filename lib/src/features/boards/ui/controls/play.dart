import 'package:aac/src/features/boards/ui/controls/control.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Play extends ConsumerWidget {
  const Play({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Control(
      icon: Icons.play_arrow,
      backgroundColor: AacColors.mainControlBackground,
      onPressed: () => ref
          .read(ttsManagerProvider)
          .saySentence(ref.read(sentenceNotifierProvider)),
    );
  }
}
