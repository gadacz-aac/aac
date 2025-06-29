import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_dao.g.dart';

@riverpod
BoardDao boardDao(Ref ref) {
  final db = ref.watch(dbProvider);
  return BoardDao(db);
}

@DriftAccessor(include: {"drift/board_queries.drift"})
class BoardDao extends DatabaseAccessor<AppDatabase> with _$BoardDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  BoardDao(super.db);

  Future<int> createOrUpdateChildBoard(BoardEditModel boardParams) {
    return this.db.managers.boardTb.create(
        (o) => o(
            id: Value.absentIfNull(boardParams.id),
            name: boardParams.name,
            crossAxisCount: Value(boardParams.columnCount ?? 3)),
        mode: InsertMode.replace);
  }

  Stream<Board?> watchById(int id) {
    return selectById(id)
        .watchSingleOrNull()
        .map((e) => e == null ? null : Board.fromEntity(e));
  }
}
