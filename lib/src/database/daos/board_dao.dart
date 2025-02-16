import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_dao.g.dart';

@DriftAccessor(include: {"board_queries.drift"})
class BoardDao extends DatabaseAccessor<AppDatabase> with _$BoardDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  BoardDao(super.db);

  Stream<BoardOld> watchById(int id) {
    return selectById(id).watchSingle().map(BoardOld.fromEntity);
  }
}

@riverpod
BoardDao boardDao(Ref ref) {
  final db = ref.watch(dbProvider);
  return BoardDao(db);
}
