import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:aac/src/shared/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final foundBoards = FutureProvider.autoDispose<List<Board>>((ref) async {
  final isar = ref.watch(isarPod);
  final query = ref.watch(queryProvider);

  return isar.boards.where().wordsElementStartsWith(query).findAll();
});

class BoardSearch extends ConsumerWidget {
  const BoardSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(foundBoards).valueOrNull;
    final query = ref.watch(queryProvider);
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 27.0),
      child: Column(
        children: [
          //TODO Standarise with Generic Text Field
          AacTextField(
            icon: const Icon(Icons.search),
            placeholder: "Szukaj w tablicach",
            onChanged: (value) {
              final debounce = Debouncer(const Duration(milliseconds: 300));
              debounce(() =>
                  ref.read(queryProvider.notifier).update((state) => value));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          results == null || results.isEmpty
              ? Text(
                  "Hmm.. nie znaleźliśmy wyników dla \"$query\"",
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final board = results[index];
                    return ListTile(
                      onTap: () => Navigator.pop(
                          context, BoardEditingParams.fromBoard(board)),
                      title: Text(
                        board.name,
                      ),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
