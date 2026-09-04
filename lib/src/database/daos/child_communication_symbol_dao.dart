import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/bin/models.dart';
import 'package:aac/src/features/symbols/model/child_communication_symbol.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'child_communication_symbol_dao.g.dart';

@DriftAccessor(include: {"drift/child_communication_symbol_queries.drift"})
class ChildSymbolDao extends DatabaseAccessor<AppDatabase>
    with _$ChildSymbolDaoMixin {
  ChildSymbolDao(super.db);

  ChildCommunicationSymbol _map(SelectByBoardIdResult res) {
    return ChildCommunicationSymbol(
      label: res.label,
      id: res.id,
      imagePath: res.imagePath,
      vocalization: res.vocalization,
      color: res.color,
      isDeleted: res.isDeleted,
      childBoardId: res.childBoardId,
      position: res.position,
      hidden: res.hidden,
      parentBoardId: res.boardId,
    );
  }

  Stream<List<ChildCommunicationSymbol>> watchByBoardId(
      int id, bool isDeleted) {
    return selectByBoardId(id, isDeleted).map(_map).watch();
  }

  Future<List<ChildCommunicationSymbol>> findByBoardId(int id, bool isDeleted) {
    return selectByBoardId(id, isDeleted).map(_map).get();
  }

  Future<List<SelectableCommunicationSymbol>> findByBoardIdWithIsReused(
      int id) async {
    final res = await selectByBoardIdWithIsReused(id).get();

    return res
        .map((e) => SelectableCommunicationSymbol(
              id: e.id,
              imagePath: e.imagePath,
              label: e.label,
              isSelected: e.isReused,
            ))
        .toList();
  }

  /// Persists new positions for symbols of [boardId]. Only the ids present in
  /// [positionBySymbolId] are updated, every other symbol keeps its current
  /// position, so free slots (missing positions) are left untouched.
  Future<void> updatePositions(
      int boardId, Map<int, int> positionBySymbolId) {
    return this.db.transaction(() async {
      for (final entry in positionBySymbolId.entries) {
        await (this.db.update(this.db.childSymbolTb)
              ..where((tbl) =>
                  tbl.boardId.equals(boardId) &
                  tbl.symbolId.equals(entry.key)))
            .write(ChildSymbolTbCompanion(position: Value(entry.value)));
      }
    });
  }
}

@riverpod
ChildSymbolDao childSymbolDao(Ref ref) {
  final db = ref.watch(dbProvider);
  return ChildSymbolDao(db);
}
