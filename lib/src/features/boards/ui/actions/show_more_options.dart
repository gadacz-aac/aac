import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/shared/ui/show_more_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardShowMoreOptions extends ConsumerWidget {
  const BoardShowMoreOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardId = ref.watch(boardIdProvider);

    return ShowMoreOptions(builder: (context) {
      return ProviderScope(
          overrides: [boardIdProvider.overrideWithValue(boardId)],
          child: const BoardBottomSheetOptions());
    });
  }
}
