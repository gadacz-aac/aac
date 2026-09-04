import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/boards/ui/symbols_grid/base_symbols_grid.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopupBoardRoute extends PopupRoute<void> {
  final int id;

  /// Accessibility label for the route barrier, localized by the caller.
  final String? barrierLabelText;

  PopupBoardRoute(this.id, {this.barrierLabelText});

  @override
  Color? get barrierColor => Colors.black.withAlpha(0x50);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => barrierLabelText;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Consumer(builder: (context, ref, child) {
      final board = ref.watch(boardProvider(id)).value;
      final symbols = ref.watch(childSymbolProvider(id, true)).value;

      if (board == null) return SizedBox();
      if (symbols == null) return SizedBox();

      return SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(4),
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(board.name),
                  actions: [
                    IconButton(
                        onPressed: Navigator.of(context).pop,
                        icon: Icon(Icons.close))
                  ],
                ),
                body: Column(
                  children: [
                    BaseSymbolsGrid(
                      itemBuilder: (context, index) {
                        return SymbolCard(symbol: symbols[index]);
                      },
                      itemCount: symbols.length,
                      crossAxisCount: board.crossAxisCount,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
