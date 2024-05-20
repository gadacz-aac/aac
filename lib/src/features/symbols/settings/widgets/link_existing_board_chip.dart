import 'package:aac/src/features/symbols/settings/screens/board_search_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_picker.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinkExistingBoardChip extends ConsumerWidget {
  const LinkExistingBoardChip({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
        avatar: const Icon(Icons.search_outlined),
        onPressed: () {
          showModalBottomSheet<BoardEditingParams?>(
                  backgroundColor: Colors.white,
                  context: context,
                  isDismissible: true,
                  builder: (context) => const BoardSearch())
              .then(ref.read(boardNotifierProvider.notifier).set);
        },
        label: const Text("Wyszukaj istniejącą"));
  }
}
