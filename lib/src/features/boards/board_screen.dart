import 'package:aac/src/features/boards/ui/controls/create_symbol.dart';
import 'package:aac/src/features/boards/ui/controls/delete_all.dart';
import 'package:aac/src/features/boards/ui/controls/pagination.dart';
import 'package:aac/src/features/boards/ui/controls/remove_last_word.dart';
import 'package:aac/src/features/boards/ui/symbols_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/boards/ui/controls_wrapper.dart';
import 'package:aac/src/features/boards/ui/lock_button.dart';
import 'package:aac/src/features/boards/ui/pin_symbol_action.dart';
import 'package:aac/src/features/boards/ui/sentence_bar.dart';
import 'package:aac/src/shared/colors.dart';

final isParentModeProvider = StateProvider<bool>((_) => false);

class BoardScreen extends ConsumerWidget {
  BoardScreen({super.key, this.title = 'dupa', required this.boardId}) {
    _isMainBoard = boardId != 1;
  }

  final String title;
  final Id boardId;
  late final bool _isMainBoard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardProvider(boardId));
    final isParentMode = ref.watch(isParentModeProvider);
    return board.when(
        error: (error, _) => ErrorScreen(error: error.toString()),
        loading: () => Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
        data: (data) {
          if (data == null) {
            return ErrorScreen(
              error: "Board with id $boardId wasn't found",
            );
          }

          List<Widget> actions = [];
          Widget? floatingActionButton;

          final List<Widget> controls = [
            const PaginationControl(
              direction: SymbolGridScrollDirection.backward,
            ),
            const PaginationControl(
                direction: SymbolGridScrollDirection.forward),
          ];

          if (isParentMode) {
            actions.add(PinSymbolsAction(
              board: data,
            ));
            controls.add(CreateSymbol(
              boardId: boardId,
            ));
          } else {
            actions.add(const LockButton());
            controls.addAll([
              const RemoveLastWord(),
              const DeleteAll(),
            ]);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              automaticallyImplyLeading: isParentMode || _isMainBoard,
              actions: actions,
              backgroundColor: AacColors.sentenceBarGrey,
              elevation: 0,
              scrolledUnderElevation: 0,
              iconTheme: const IconThemeData(color: AacColors.iconsGrey),
              centerTitle: true,
              titleTextStyle: const TextStyle(color: Colors.black),
            ),
            body: OrientationBuilder(
              builder: (context, orientation) {
                final List<Widget> children;
                if (orientation == Orientation.landscape) {
                  children = [
                    !isParentMode ? const SentenceBar() : const SizedBox(),
                    Expanded(
                      child: Row(
                        children: [
                          SymbolsGrid(board: data),
                          ControlsWrapper(
                              direction: Axis.vertical, children: controls)
                        ],
                      ),
                    )
                  ];
                } else {
                  children = [
                    !isParentMode ? const SentenceBar() : const SizedBox(),
                    SymbolsGrid(board: data),
                    ControlsWrapper(
                      direction: Axis.horizontal,
                      children: controls,
                    )
                  ];
                }
                return ProviderScope(
                  overrides: [
                    symbolGridScrollControllerProvider,
                    symbolGridScrollPossibilityProvider
                  ],
                  child: Column(children: children),
                );
              },
            ),
            floatingActionButton: floatingActionButton,
          );
        });
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Oops..')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/oops-steve-carell.gif',
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            error,
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ]),
      ),
    );
  }
}
