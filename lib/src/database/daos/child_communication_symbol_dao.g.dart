// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_communication_symbol_dao.dart';

// ignore_for_file: type=lint
mixin _$ChildSymbolDaoMixin on DatabaseAccessor<AppDatabase> {
  BoardTb get boardTb => attachedDatabase.boardTb;
  CommunicationSymbolTb get communicationSymbolTb =>
      attachedDatabase.communicationSymbolTb;
  ChildSymbolTb get childSymbolTb => attachedDatabase.childSymbolTb;
  SettingTb get settingTb => attachedDatabase.settingTb;
  Selectable<SelectByBoardIdResult> selectByBoardId(int var1, bool var2) {
    return customSelect(
        'SELECT * FROM communication_symbol_tb AS s JOIN child_symbol_tb AS cs ON cs.symbol_id = s.id WHERE cs.board_id = ?1 AND s.is_deleted = ?2 ORDER BY cs.position',
        variables: [
          Variable<int>(var1),
          Variable<bool>(var2)
        ],
        readsFrom: {
          this.communicationSymbolTb,
          this.childSymbolTb,
        }).map((QueryRow row) => SelectByBoardIdResult(
          id: row.read<int>('id'),
          label: row.read<String>('label'),
          imagePath: row.read<String>('image_path'),
          vocalization: row.readNullable<String>('vocalization'),
          color: row.readNullable<int>('color'),
          isDeleted: row.read<bool>('is_deleted'),
          createdAt: row.readNullable<int>('created_at'),
          childBoardId: row.readNullable<int>('child_board_id'),
          position: row.read<int>('position'),
          hidden: row.read<bool>('hidden'),
          boardId: row.read<int>('board_id'),
          symbolId: row.read<int>('symbol_id'),
        ));
  }

  Future<int> toggleVisibility({required int boardId, required int symbolId}) {
    return customUpdate(
      'UPDATE child_symbol_tb SET hidden = NOT hidden WHERE board_id = ?1 AND symbol_id = ?2',
      variables: [Variable<int>(boardId), Variable<int>(symbolId)],
      updates: {this.childSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> markDeletedByParentId(int var1) {
    return customUpdate(
      'UPDATE communication_symbol_tb SET is_deleted = TRUE FROM (SELECT cs.symbol_id FROM child_symbol_tb AS cs LEFT JOIN child_symbol_tb AS other ON cs.symbol_id = other.symbol_id AND other.board_id <> cs.board_id WHERE cs.board_id = ?1 AND other.symbol_id IS NULL) AS orphans WHERE communication_symbol_tb.id = orphans.symbol_id',
      variables: [Variable<int>(var1)],
      updates: {this.communicationSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> removeLinksToParent(int? var1) {
    return customUpdate(
      'UPDATE communication_symbol_tb SET child_board_id = NULL WHERE child_board_id = ?1',
      variables: [Variable<int>(var1)],
      updates: {this.communicationSymbolTb},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<SelectByBoardIdWithIsReusedResult> selectByBoardIdWithIsReused(
      int var1) {
    return customSelect(
        'SELECT s.label, s.id, s.image_path,(COUNT(*) > 1)AS is_reused FROM child_symbol_tb AS cs1 JOIN child_symbol_tb AS cs2 ON cs1.symbol_id = cs2.symbol_id JOIN communication_symbol_tb AS s ON cs1.symbol_id = s.id WHERE cs1.board_id = ?1 OR cs2.board_id = ?1 GROUP BY s.id',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          this.communicationSymbolTb,
          this.childSymbolTb,
        }).map((QueryRow row) => SelectByBoardIdWithIsReusedResult(
          label: row.read<String>('label'),
          id: row.read<int>('id'),
          imagePath: row.read<String>('image_path'),
          isReused: row.read<bool>('is_reused'),
        ));
  }

  ChildSymbolDaoManager get managers => ChildSymbolDaoManager(this);
}

class ChildSymbolDaoManager {
  final _$ChildSymbolDaoMixin _db;
  ChildSymbolDaoManager(this._db);
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

class SelectByBoardIdResult {
  final int id;
  final String label;
  final String imagePath;
  final String? vocalization;
  final int? color;
  final bool isDeleted;
  final int? createdAt;
  final int? childBoardId;
  final int position;
  final bool hidden;
  final int boardId;
  final int symbolId;
  SelectByBoardIdResult({
    required this.id,
    required this.label,
    required this.imagePath,
    this.vocalization,
    this.color,
    required this.isDeleted,
    this.createdAt,
    this.childBoardId,
    required this.position,
    required this.hidden,
    required this.boardId,
    required this.symbolId,
  });
}

class SelectByBoardIdWithIsReusedResult {
  final String label;
  final int id;
  final String imagePath;
  final bool isReused;
  SelectByBoardIdWithIsReusedResult({
    required this.label,
    required this.id,
    required this.imagePath,
    required this.isReused,
  });
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(childSymbolDao)
final childSymbolDaoProvider = ChildSymbolDaoProvider._();

final class ChildSymbolDaoProvider
    extends $FunctionalProvider<ChildSymbolDao, ChildSymbolDao, ChildSymbolDao>
    with $Provider<ChildSymbolDao> {
  ChildSymbolDaoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'childSymbolDaoProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childSymbolDaoHash();

  @$internal
  @override
  $ProviderElement<ChildSymbolDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChildSymbolDao create(Ref ref) {
    return childSymbolDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChildSymbolDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChildSymbolDao>(value),
    );
  }
}

String _$childSymbolDaoHash() => r'b87a37abebb020ec29034ea14db1572d774abdcd';
