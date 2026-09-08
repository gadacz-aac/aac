import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_dao.g.dart';

@Riverpod(keepAlive: true)
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
    if (boardParams.id != null) {
      // REPLACE would delete the row and cascade-delete its child_symbol_tb
      // rows (ON DELETE CASCADE), so existing boards are only updated.
      return (this.db.update(this.db.boardTb)
            ..where((tbl) => tbl.id.equals(boardParams.id!)))
          .write(BoardTbCompanion(
              name: Value(boardParams.name),
              crossAxisCount: Value(boardParams.columnCount ?? 3)))
          .then((_) => boardParams.id!);
    }

    return this.db.managers.boardTb.create(
        (o) => o(
            name: boardParams.name,
            crossAxisCount: Value(boardParams.columnCount ?? 3)),
        mode: InsertMode.insert);
  }

  Stream<Board?> watchById(int id) {
    return selectById(id)
        .watchSingleOrNull()
        .map((e) => e == null ? null : Board.fromEntity(e));
  }

  Stream<List<Board>> watchDeleted() {
    return selectDeleted().map(Board.fromEntity).watch();
  }
}
