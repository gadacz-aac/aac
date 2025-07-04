// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_communication_symbol_dao.dart';

// ignore_for_file: type=lint
mixin _$ChildSymbolDaoMixin on DatabaseAccessor<AppDatabase> {
  BoardTb get boardTb => attachedDatabase.boardTb;
  CommunicationSymbolTb get communicationSymbolTb =>
      attachedDatabase.communicationSymbolTb;
  ChildSymbolTb get childSymbolTb => attachedDatabase.childSymbolTb;
  SettingTb get settingTb => attachedDatabase.settingTb;
  Selectable<SelectByBoardIdResult> selectByBoardId(int var1) {
    return customSelect(
        'SELECT * FROM communication_symbol_tb AS s JOIN child_symbol_tb AS cs ON cs.symbol_id = s.id WHERE cs.board_id = ?1 AND s.is_deleted = FALSE ORDER BY cs.position',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          communicationSymbolTb,
          childSymbolTb,
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
      updates: {childSymbolTb},
      updateKind: UpdateKind.update,
    );
  }
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

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$childSymbolDaoHash() => r'b87a37abebb020ec29034ea14db1572d774abdcd';

/// See also [childSymbolDao].
@ProviderFor(childSymbolDao)
final childSymbolDaoProvider = AutoDisposeProvider<ChildSymbolDao>.internal(
  childSymbolDao,
  name: r'childSymbolDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$childSymbolDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChildSymbolDaoRef = AutoDisposeProviderRef<ChildSymbolDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
