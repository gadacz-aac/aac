import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/boards/ui/lock_button.dart';
import 'package:aac/src/features/boards/ui/pin_symbol_action.dart';
import 'package:aac/src/features/boards/ui/sentence_bar.dart';
import 'package:aac/src/features/symbols/randomise_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isar/isar.dart';

import '../symbols/create_symbol_screen.dart';
import 'model/board.dart';

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
          if (isParentMode) {
            floatingActionButton = Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CreateSymbolFloatingButton(boardId: boardId),
                RandomiseSymbolFloatingButton(boardId: boardId)
              ],
            );
            actions.add(PinSymbolsAction(
              board: data,
            ));
          } else {
            actions.add(const LockButton());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              automaticallyImplyLeading: isParentMode || _isMainBoard,
              actions: actions,
              backgroundColor: AacColors.sentenceBarGrey,
              elevation: 0,
              iconTheme: IconThemeData(color: AacColors.iconsGrey),
              centerTitle: true,
              titleTextStyle: const TextStyle(color: Colors.black),
            ),
            body: Column(
              children: [
                const SentenceBar(),
                SymbolsGrid(
                  board: data,
                )
              ],
            ),
            floatingActionButton: floatingActionButton,
          );
        });
  }
}

class CreateSymbolFloatingButton extends StatelessWidget {
  const CreateSymbolFloatingButton({
    super.key,
    required this.boardId,
  });

  final Id boardId;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddSymbolMenu(boardId: boardId)));
      },
      heroTag: null,
      child: const Icon(Icons.add),
    );
  }
}

class RandomiseSymbolFloatingButton extends ConsumerWidget {
  const RandomiseSymbolFloatingButton({
    super.key,
    required this.boardId,
  });

  final Id boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        randomiseSymbol(ref, boardId);
      },
      heroTag: null,
      child: const Icon(Icons.shuffle),
    );
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

class SymbolsGrid extends StatelessWidget {
  const SymbolsGrid({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AlignedGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          itemCount: board.symbols.length,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (context, index) {
            final e = board.symbols.elementAt(index);
            return SymbolCard(symbol: e, board: board);
          }),
    );
  }
}
