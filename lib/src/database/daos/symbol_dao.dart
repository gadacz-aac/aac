import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_dao.g.dart';

@DriftAccessor(include: {"drift/symbol_queries.drift"})
class SymbolDao extends DatabaseAccessor<AppDatabase> with _$SymbolDaoMixin {
  SymbolDao(super.db);

  Future<CommunicationSymbolEntity> findById(int id) {
    return this
        .db
        .managers
        .communicationSymbolTb
        .filter((f) => f.id(id))
        .getSingle();
  }

  Future<CommunicationSymbol?> findByLabel(String label) {
    return this
        .db
        .managers
        .communicationSymbolTb
        .filter((f) => f.label(label))
        .map(CommunicationSymbol.fromEntity)
        .getSingleOrNull();
  }

  Future<int> create(SymbolEditModel params, [int? childBoardId]) {
    return this.db.managers.communicationSymbolTb.create((o) => o(
        label: params.label ?? "",
        color: Value(params.color),
        imagePath: params.imagePath ?? "",
        isDeleted: Value.absentIfNull(params.isDeleted),
        vocalization: Value.absentIfNull(params.vocalization),
        childBoardId: Value.absentIfNull(childBoardId)));
  }

  Future<void> updateWith(SymbolEditModel params, int? childBoardId) async {
    if (params.id != null) {
      ArgumentError.notNull("ID must not be null for update");
    }

    var cs = await findById(params.id!);

    cs = cs.copyWithCompanion(CommunicationSymbolTbCompanion(
        color: Value.absentIfNull(params.color),
        label: Value.absentIfNull(params.label),
        imagePath: Value.absentIfNull(params.imagePath),
        isDeleted: Value.absentIfNull(params.isDeleted),
        childBoardId: Value(childBoardId),
        vocalization: Value.absentIfNull(params.vocalization)));

    await this.db.managers.communicationSymbolTb.replace(cs);
  }

  /// [boardId] is optional, if null, symbols will be unpinned from all boards
  Future<void> unpinSymbols(
      List<CommunicationSymbol> symbols, int? boardId) async {
    final symbolIds = symbols.map((e) => e.id);

    final filter = boardId == null
        ? ($ChildSymbolTbFilterComposer f) => f.symbolId.id.isIn(symbolIds)
        : ($ChildSymbolTbFilterComposer f) =>
            f.boardId.id(boardId) & f.symbolId.id.isIn(symbolIds);

    await this.db.managers.childSymbolTb.filter(filter).delete();
  }

  Stream<List<CommunicationSymbol>> watchDeleted() {
    return selectDeleted().map(CommunicationSymbol.fromEntity).watch();
  }
}

@riverpod
SymbolDao symbolDao(Ref ref) {
  final db = ref.watch(dbProvider);
  return SymbolDao(db);
}
