import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/controls/control.dart';
import 'package:aac/src/features/boards/ui/controls/controls_wrapper.dart';
import 'package:aac/src/features/symbols/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
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
      .limit(3)
      .watch(fireImmediately: true);
}

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AacColors.greyBackground,
          scrolledUnderElevation: 0,
          title: Hero(
              tag: "search",
              child: Material(
                child: AacSearchField(
                    readOnly: true,
                    onClick: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                            pageBuilder: (context, a1, a2) =>
                                const SymbolSearchScreen())),
                    placeholder: "Szukaj"),
              )),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        backgroundColor: AacColors.greyBackground,
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 23.0,
            ),
            OverviewSectionTitle("Ostatnio Edytowane"),
            RecentSymbols(),
            SizedBox(
              height: 29.0,
            ),
            OverviewSectionTitle("Ostatnio Edytowane"),
            SizedBox(
              height: 8,
            ),
            RecentBoards(),
            ControlsWrapper(children: [
              Control(icon: Icons.home_outlined),
              Control(icon: Icons.lock_outline),
              Control(icon: Icons.search_outlined),
              Control(icon: Icons.add_box_outlined),
            ])
          ],
        ));
  }
}

class OverviewSectionTitle extends StatelessWidget {
  const OverviewSectionTitle(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1, color: const Color(0xFFE9E9E9))),
          child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
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
      padding: const EdgeInsets.only(left: 8),
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
