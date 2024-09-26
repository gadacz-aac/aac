import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/boards/ui/actions/lock_button.dart';
import 'package:aac/src/features/boards/ui/actions/pin_symbol_action.dart';
import 'package:aac/src/features/boards/ui/actions/show_more_options.dart';
import 'package:aac/src/features/boards/ui/app_bar.dart';
import 'package:aac/src/features/boards/ui/controls/controls_wrapper.dart';
import 'package:aac/src/features/boards/ui/controls/create_symbol.dart';
import 'package:aac/src/features/boards/ui/controls/delete_all.dart';
import 'package:aac/src/features/boards/ui/controls/pagination.dart';
import 'package:aac/src/features/boards/ui/controls/remove_last_word.dart';
import 'package:aac/src/features/boards/ui/sentence_bar.dart';
import 'package:aac/src/features/boards/ui/symbols_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/boards/ui/controls/controls_wrapper.dart';
import 'package:aac/src/features/boards/ui/sentence_bar.dart';

// in debug mode parent mode default
// in release mode child mode default
final isParentModeProvider = StateProvider<bool>((_) => kDebugMode);
final boardIdProvider = Provider<Id>((_) => throw UnimplementedError());

class BoardScreen extends ConsumerWidget {
  BoardScreen({super.key, required this.boardId}) {
    _isMainBoard = boardId != 1;
  }

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

          final List<Widget> controls = [];

          if (isParentMode) {
            actions.addAll([
              PinSymbolsAction(
                board: data,
              ),
              const ShowMoreOptions()
            ]);
          } else {
            actions.add(const LockButton());
            controls.addAll([
              const PaginationControl(
                direction: SymbolGridScrollDirection.backward,
              ),
              const PaginationControl(
                  direction: SymbolGridScrollDirection.forward),
              const RemoveLastWord(),
              const DeleteAll(),
            ]);
          }

          return ProviderScope(
            overrides: [boardIdProvider.overrideWithValue(boardId)],
            child: Scaffold(
              appBar: BoardAppBar(
                  title: data.name,
                  isParentMode: isParentMode,
                  isMainBoard: _isMainBoard,
                  actions: actions),
              floatingActionButton: isParentMode ? const CreateSymbol() : null,
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
            ),
          );
        });
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.error,
  });

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
