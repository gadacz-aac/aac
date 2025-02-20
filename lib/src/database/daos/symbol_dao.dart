import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_dao.g.dart';

@DriftAccessor(include: {"symbol_queries.drift"})
class SymbolDao extends DatabaseAccessor<AppDatabase> with _$SymbolDaoMixin {
  SymbolDao(super.db);

  Stream<List<CommunicationSymbolOld>> watchByBoardId(int id) {
    return selectByBoardId(id)
        .map(CommunicationSymbolOld.fromEntity)
        .watch();
  }
}

@riverpod
SymbolDao symbolDao(Ref ref) {
  final db = ref.watch(dbProvider);
  return SymbolDao(db);
}
