import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/main_menu/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

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
