import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/isar_provider.dart';

part 'board_manager.g.dart';

final boardProvider =
    StreamProvider.autoDispose.family<Board?, Id>((ref, id) async* {
  final manager = ref.watch(boardManagerProvider);
  yield* manager.watchBoardById(id);
});

@riverpod
BoardManager boardManager(BoardManagerRef ref) {
  final isar = ref.watch(isarProvider);
  return BoardManager(isar: isar);
}

class BoardManager {
  final Isar isar;

  BoardManager({
    required this.isar,
  });

  Future<Board> createOrUpdate(BoardEditingParams params) async {
    print(params);
    final board = Board.fromParams(params);
    print(board);
    isar.writeTxn(() async {
      await isar.boards.put(board);
    });

    return board;
  }

  Stream<Board?> watchBoardById(Id id) async* {
    yield* isar.boards.watchObject(id, fireImmediately: true);
  }
}
