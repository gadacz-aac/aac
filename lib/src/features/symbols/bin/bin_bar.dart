import 'package:aac/src/features/boards/ui/actions/delete_forever_action.dart';
import 'package:aac/src/features/boards/ui/actions/restore_symbol_action.dart';
import 'package:aac/src/features/symbols/search/app_bar_actions.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BinAppBar({
    super.key,
    required this.title,
    this.actions = const [],
  });

  final String title;
  final List<Widget> actions;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areSymbolSelected = ref.watch(areSymbolsSelectedProvider);
    final List<Widget> actionsSelected = [
      const DeleteForeverAction(),
      const RestoreSymbolAction()
    ];

    return AppBar(
      title: areSymbolSelected ? null : Text(title),
      leading: areSymbolSelected ? const CancelAction() : null,
      actions: areSymbolSelected ? actionsSelected : actions,
      backgroundColor: AacColors.sentenceBarGrey,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: AacColors.iconsGrey),
      centerTitle: true,
      titleTextStyle: const TextStyle(color: Colors.black),
    );
  }
}
