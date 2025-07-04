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
      updates: {childSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> pinSymbolToBoard({required int boardId, required int symbolId}) {
    return customInsert(
      'WITH helpers AS (SELECT(COALESCE((SELECT MAX(position) FROM child_symbol_tb WHERE board_id = ?1), -1) + 1)AS position) INSERT OR REPLACE INTO child_symbol_tb (board_id, symbol_id, position) VALUES (?1, ?2, (SELECT position FROM helpers))',
      variables: [Variable<int>(boardId), Variable<int>(symbolId)],
      updates: {childSymbolTb},
    );
  }

  Selectable<CommunicationSymbolEntity> searchSymbol(
      {required String query, required bool onlyPinned, int? color}) {
    return customSelect(
        'SELECT s.* FROM communication_symbol_tb AS s LEFT JOIN child_symbol_tb AS cs ON cs.symbol_id = s.id WHERE s.label LIKE CONCAT(\'%\', ?1, \'%\') AND(NOT ?2 OR cs.board_id IS NULL)AND(?3 IS NULL OR s.color = ?3)AND is_deleted = FALSE',
        variables: [
          Variable<String>(query),
          Variable<bool>(onlyPinned),
          Variable<int>(color)
        ],
        readsFrom: {
          communicationSymbolTb,
          childSymbolTb,
        }).asyncMap(communicationSymbolTb.mapFromRow);
  }

  Future<int> markAsDeleted(int var1) {
    return customUpdate(
      'UPDATE communication_symbol_tb SET is_deleted = TRUE WHERE id = ?1',
      variables: [Variable<int>(var1)],
      updates: {communicationSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> restoreSymbol(int var1) {
    return customUpdate(
      'UPDATE communication_symbol_tb SET is_deleted = FALSE WHERE id = ?1',
      variables: [Variable<int>(var1)],
      updates: {communicationSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deletePermanently(int var1) {
    return customUpdate(
      'DELETE FROM communication_symbol_tb WHERE id = ?1',
      variables: [Variable<int>(var1)],
      updates: {communicationSymbolTb},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<CommunicationSymbolEntity> selectDeleted() {
    return customSelect(
        'SELECT * FROM communication_symbol_tb WHERE is_deleted = TRUE',
        variables: [],
        readsFrom: {
          communicationSymbolTb,
        }).asyncMap(communicationSymbolTb.mapFromRow);
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$symbolDaoHash() => r'1e9bae0724467797d5b8e177c63b84f2baeff35f';

/// See also [symbolDao].
@ProviderFor(symbolDao)
final symbolDaoProvider = AutoDisposeProvider<SymbolDao>.internal(
  symbolDao,
  name: r'symbolDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$symbolDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SymbolDaoRef = AutoDisposeProviderRef<SymbolDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
