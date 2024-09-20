import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowMoreOptions extends ConsumerWidget {
  const ShowMoreOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardId = ref.watch(boardIdProvider);

    return IconButton(
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return ProviderScope(
                    overrides: [boardIdProvider.overrideWithValue(boardId)],
                    child: const BottomSheetOptions());
              },
            ),
        icon: const Icon(Icons.more_vert));
  }
}
