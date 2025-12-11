import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_manager.g.dart';

final boardProvider =
    StreamProvider.autoDispose.family<Board?, int>((ref, id) async* {
  final dao = ref.watch(boardDaoProvider);
  yield* dao.watchById(id);
});

@riverpod
BoardManager boardManager(Ref ref) {
  final db = ref.watch(dbProvider);
  final boardDao = ref.watch(boardDaoProvider);
  return BoardManager(
    db,
    boardDao,
  );
}

class BoardManager {
  AppDatabase db;
  BoardDao boardDao;

  BoardManager(this.db, this.boardDao);

  Future<void> createOrUpdate(BoardEditModel params) {
    return db.managers.boardTb.create(
        (f) => f(
            id: Value.absentIfNull(params.id),
            name: params.name,
            crossAxisCount: Value(params.columnCount ?? 3)),
        mode: InsertMode.replace);
  }
}
