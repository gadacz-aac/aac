import 'package:aac/src/features/boards/ui/actions/delete_forever_action.dart';
import 'package:aac/src/features/boards/ui/actions/move_symbol_to_bin_action.dart';
import 'package:aac/src/features/symbols/search/app_bar_actions.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/shared/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  ConsumerState<SearchAppBar> createState() => _SearchAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends ConsumerState<SearchAppBar> {
  final controller = TextEditingController();
  final _debounce = Debouncer(const Duration(milliseconds: 300));
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => ref.read(queryProvider.notifier).state = controller.text);
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final areSelected = ref.watch(areSymbolsSelectedProvider);

    List<Widget>? actions;
    Widget? title;

    void clearOrPop() {
      if (controller.text.isEmpty) {
        Navigator.pop(context);
        return;
      }

      controller.clear();
    }

    if (areSelected) {
      actions = [const PinSelectedSymbolAction(), const MoveSymbolToBinAction()];
    } else {
      title = Hero(
        tag: "search",
        child: Material(
          child: AacSearchField(
            focusNode: focusNode,
            placeholder: "Szukaj",
            controller: controller,
            suffixIcon: IconButton(
                onPressed: clearOrPop, icon: const Icon(Icons.cancel)),
          ),
        ),
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
    );
  }
}
