import 'package:aac/src/features/boards/ui/actions/delete_forever_action.dart';
import 'package:aac/src/features/boards/ui/actions/restore_symbol_action.dart';
import 'package:aac/src/features/symbols/search/app_bar_actions.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const BinAppBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  final TabController tabController;
  final List<Tab> tabs;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final areSymbolSelected = ref.watch(areSymbolsSelectedProvider);

    List<Widget> actions = [];
    Widget? flexibleSpace;

    if (areSymbolSelected) {
      actions = [const DeleteForeverAction(), const RestoreSymbolAction()];
    } else {
      flexibleSpace = SafeArea(
        child: TabBar(
          controller: tabController,
          tabs: tabs,
        ),
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      leading: areSymbolSelected ? const CancelAction() : null,
      actions: actions,
      backgroundColor: AacColors.sentenceBarGrey,
      flexibleSpace: flexibleSpace,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: AacColors.iconsGrey),
      titleTextStyle: const TextStyle(color: Colors.black),
    );
  }
}
