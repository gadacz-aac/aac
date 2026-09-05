import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/settings/screens/board_search_screen.dart';
import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_picker.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([BoardNotifier])
class LinkNewBoardChip extends ConsumerWidget {
  const LinkNewBoardChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      avatar: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<BoardEditModel?>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) =>
                const CreateBoardScreen(params: BoardEditModel())).then((val) {
          if (val == null) return;
          ref.read(boardProvider.notifier).set(val);
        });
      },
      label: Text(AppLocalizations.of(context).addNewBoard),
    );
  }
}

@Dependencies([BoardNotifier])
class LinkExistingBoardChip extends ConsumerWidget {
  const LinkExistingBoardChip({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
        avatar: const Icon(Icons.search_outlined),
        onPressed: () {
          showModalBottomSheet<BoardEditModel?>(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  useSafeArea: true,
                  builder: (context) => const BoardSearch())
              .then(ref.read(boardProvider.notifier).set);
        },
        label: Text(AppLocalizations.of(context).findExistingBoard));
  }
}

@Dependencies([BoardNotifier])
class LinkedBoardChip extends ConsumerWidget {
  const LinkedBoardChip({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childBoard = ref.watch(boardProvider).value;

    if (childBoard == null) return const SizedBox();

    return InputChip(
      avatar: const Icon(Icons.apps_outlined),
      label: Text(childBoard.name),
      onPressed: () => showModalBottomSheet<BoardEditModel?>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => CreateBoardScreen(params: childBoard))
              .then((val) {
        if (val == null) return;
        ref.read(boardProvider.notifier).set(val);
      }),
      onDeleted: () => ref.read(boardProvider.notifier).delete(),
    );
  }
}
