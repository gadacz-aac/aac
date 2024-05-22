import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overview_screen.g.dart';

@riverpod
Stream<List<CommunicationSymbol>> recentlyEditedSymbols(
    RecentlyEditedSymbolsRef ref) {
  final isar = ref.watch(isarProvider);

  return isar.communicationSymbols
      .where(sort: Sort.desc)
      .limit(10)
      .watch(fireImmediately: true);
}

@riverpod
Stream<List<Board>> recentylEditedBoard(RecentylEditedBoardRef ref) {
  final isar = ref.watch(isarProvider);

  return isar.boards
      .where(sort: Sort.desc)
      .limit(10)
      .watch(fireImmediately: true);
}

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AacColors.greyBackground,
        body: Column(
          children: [
            RecentSymbols(),
            SizedBox(
              height: 29.0,
            ),
            RecentBoards()
          ],
        ));
  }
}

class RecentBoards extends ConsumerWidget {
  const RecentBoards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boards = ref.watch(recentylEditedBoardProvider).valueOrNull;
    if (boards == null) {
      return const SizedBox();
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1, color: const Color(0xFFE9E9E9))),
          child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: boards.length,
              itemBuilder: (context, index) {
                final e = boards[index];
                String title = e.name;
                String subtitle = "${e.symbols.length} symboli";
                if (title.trim().isEmpty) title = "dupa";
                return BoardTile(title: title, subtitle: subtitle, id: e.id);
              },
              separatorBuilder: (context, _) => const DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color(0xFFE9E9E9)))))),
        ),
      ),
    );
  }
}

class BoardTile extends StatelessWidget {
  const BoardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.id,
  });

  final String title;
  final String subtitle;
  final Id id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => openBoard(context),
        tileColor: Colors.white,
        title: Text(title),
        subtitle: Text(subtitle),
        trailing:
            const RotatedBox(quarterTurns: -1, child: Icon(Icons.expand_more)));
  }

  void openBoard(BuildContext context) {
    if (!context.mounted) return;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProviderScope(
                overrides: [isParentModeProvider.overrideWith((ref) => true)],
                child: BoardScreen(boardId: id))));
  }
}

class RecentSymbols extends ConsumerWidget {
  const RecentSymbols({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(recentlyEditedSymbolsProvider).valueOrNull;
    if (symbols == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(27.0, 30, 0, 0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: symbols
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            SizedBox(width: 140, child: SymbolCard(symbol: e)),
                      ))
                  .toList())),
    );
  }
}
