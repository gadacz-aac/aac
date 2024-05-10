import 'package:aac/src/features/boards/ui/controls/control.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveLastWord extends ConsumerWidget {
  const RemoveLastWord({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Control(
      icon: Icons.backspace_outlined,
      onPressed: ref.read(sentenceNotifierProvider.notifier).removeLastWord,
    );
  }
}
