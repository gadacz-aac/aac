import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/controls/control.dart';
import 'package:aac/src/features/boards/ui/controls/controls_wrapper.dart';
import 'package:aac/src/features/main_menu/recent_symbols.dart';
import 'package:aac/src/features/main_menu/ui/overview_section_title.dart';
import 'package:aac/src/features/main_menu/ui/recent_boards.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'overview_screen.g.dart';

@riverpod
Stream<List<CommunicationSymbol>> recentlyEditedSymbols(
    RecentlyEditedSymbolsRef ref) {
  final isar = ref.watch(isarProvider);

  // TODO sort by a last edited date
  return isar.communicationSymbols
      .where(sort: Sort.desc)
      .anyId()
      .limit(10)
      .watch(fireImmediately: true);
}

@riverpod
Stream<List<Board>> recentylEditedBoard(RecentylEditedBoardRef ref) {
  final isar = ref.watch(isarProvider);

  // TODO sort by a last edited date
  return isar.boards
      .where(sort: Sort.desc)
      .anyId()
      .limit(8)
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
