import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/model/child_communication_symbol.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'child_communication_symbol_dao.g.dart';

@DriftAccessor(include: {"drift/child_communication_symbol_queries.drift"})
class ChildSymbolDao extends DatabaseAccessor<AppDatabase>
    with _$ChildSymbolDaoMixin {
  ChildSymbolDao(super.db);

  Stream<List<ChildCommunicationSymbol>> watchByBoardId(int id) {
    return selectByBoardId(id)
        .map((res) => ChildCommunicationSymbol(
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
            ))
        .watch();
  }
}

@riverpod
ChildSymbolDao childSymbolDao(Ref ref) {
  final db = ref.watch(dbProvider);
  return ChildSymbolDao(db);
}
