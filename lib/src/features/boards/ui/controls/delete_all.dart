import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aac/src/features/boards/ui/controls/control.dart';
import "package:aac/src/features/text_to_speech/provider.dart";
import 'package:aac/src/shared/colors.dart';

class DeleteAll extends ConsumerWidget {
  const DeleteAll({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Control(
      icon: Icons.delete_outlined,
      backgroundColor: AacColors.controlBackgroundAttentionSucker,
      onPressed: ref.read(sentenceNotifierProvider.notifier).clear,
    );
  }
}
