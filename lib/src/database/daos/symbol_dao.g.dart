// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_dao.dart';

// ignore_for_file: type=lint
mixin _$SymbolDaoMixin on DatabaseAccessor<AppDatabase> {
  BoardTb get boardTb => attachedDatabase.boardTb;
  CommunicationSymbolTb get communicationSymbolTb =>
      attachedDatabase.communicationSymbolTb;
  ChildSymbolTb get childSymbolTb => attachedDatabase.childSymbolTb;
  SettingTb get settingTb => attachedDatabase.settingTb;
  Future<int> moveSymbol(
      {required int newPos, required int oldPos, required int boardId}) {
    return customUpdate(
      'WITH ordered AS (SELECT ?1, ?2, position AS old_position,(CASE WHEN position = ?2 THEN ?1 WHEN ?1 < ?2 AND position >= ?1 AND position < ?2 THEN position + 1 WHEN ?1 > ?2 AND position > ?2 AND position <= ?1 THEN position - 1 ELSE position END)AS new_position FROM child_symbol_tb WHERE board_id = ?3) UPDATE child_symbol_tb SET position = (SELECT new_position FROM ordered WHERE old_position = position) WHERE board_id = ?3',
      variables: [
        Variable<int>(newPos),
        Variable<int>(oldPos),
        Variable<int>(boardId)
      ],
      updates: {this.childSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> pinSymbolToBoard({required int boardId, required int symbolId}) {
    return customInsert(
      'WITH helpers AS (SELECT(COALESCE((SELECT MAX(position) FROM child_symbol_tb WHERE board_id = ?1), -1) + 1)AS position) INSERT OR REPLACE INTO child_symbol_tb (board_id, symbol_id, position) VALUES (?1, ?2, (SELECT position FROM helpers))',
      variables: [Variable<int>(boardId), Variable<int>(symbolId)],
      updates: {this.childSymbolTb},
    );
  }

  Selectable<CommunicationSymbolEntity> searchSymbol(
      {required String query, required bool onlyPinned, int? color}) {
    return customSelect(
        'SELECT DISTINCT s.* FROM communication_symbol_tb AS s LEFT JOIN child_symbol_tb AS cs ON cs.symbol_id = s.id WHERE s.label LIKE \'%\' || ?1 || \'%\' AND(NOT ?2 OR cs.board_id IS NULL)AND(?3 IS NULL OR s.color = ?3)AND is_deleted = FALSE',
        variables: [
          Variable<String>(query),
          Variable<bool>(onlyPinned),
          Variable<int>(color)
        ],
        readsFrom: {
          this.communicationSymbolTb,
          this.childSymbolTb,
        }).asyncMap(this.communicationSymbolTb.mapFromRow);
  }

  Future<int> markAsDeleted(int var1) {
    return customUpdate(
      'UPDATE communication_symbol_tb SET is_deleted = TRUE WHERE id = ?1',
      variables: [Variable<int>(var1)],
      updates: {this.communicationSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> restoreSymbol(int var1) {
    return customUpdate(
      'UPDATE communication_symbol_tb SET is_deleted = FALSE WHERE id = ?1',
      variables: [Variable<int>(var1)],
      updates: {this.communicationSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deletePermanently(int var1) {
    return customUpdate(
      'DELETE FROM communication_symbol_tb WHERE id = ?1',
      variables: [Variable<int>(var1)],
      updates: {this.communicationSymbolTb},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<CommunicationSymbolEntity> selectDeleted() {
    return customSelect(
        'SELECT * FROM communication_symbol_tb WHERE is_deleted = TRUE',
        variables: [],
        readsFrom: {
          this.communicationSymbolTb,
        }).asyncMap(this.communicationSymbolTb.mapFromRow);
  }

  SymbolDaoManager get managers => SymbolDaoManager(this);
}

class SymbolDaoManager {
  final _$SymbolDaoMixin _db;
  SymbolDaoManager(this._db);
  $BoardTbTableManager get boardTb =>
      $BoardTbTableManager(_db.attachedDatabase, _db.boardTb);
  $CommunicationSymbolTbTableManager get communicationSymbolTb =>
      $CommunicationSymbolTbTableManager(
          _db.attachedDatabase, _db.communicationSymbolTb);
  $ChildSymbolTbTableManager get childSymbolTb =>
      $ChildSymbolTbTableManager(_db.attachedDatabase, _db.childSymbolTb);
  $SettingTbTableManager get settingTb =>
      $SettingTbTableManager(_db.attachedDatabase, _db.settingTb);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(symbolDao)
final symbolDaoProvider = SymbolDaoProvider._();

final class SymbolDaoProvider
    extends $FunctionalProvider<SymbolDao, SymbolDao, SymbolDao>
    with $Provider<SymbolDao> {
  SymbolDaoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'symbolDaoProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$symbolDaoHash();

  @$internal
  @override
  $ProviderElement<SymbolDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SymbolDao create(Ref ref) {
    return symbolDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymbolDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymbolDao>(value),
    );
  }
}

String _$symbolDaoHash() => r'307c324294cceb6324725f3f51a0b71162111c79';
