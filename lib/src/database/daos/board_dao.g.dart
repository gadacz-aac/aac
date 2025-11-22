// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_dao.dart';

// ignore_for_file: type=lint
mixin _$BoardDaoMixin on DatabaseAccessor<AppDatabase> {
  BoardTb get boardTb => attachedDatabase.boardTb;
  CommunicationSymbolTb get communicationSymbolTb =>
      attachedDatabase.communicationSymbolTb;
  ChildSymbolTb get childSymbolTb => attachedDatabase.childSymbolTb;
  SettingTb get settingTb => attachedDatabase.settingTb;
  Selectable<BoardEntity> selectById(int var1) {
    return customSelect('SELECT * FROM board_tb WHERE board_tb.id = ?1',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          boardTb,
        }).asyncMap(boardTb.mapFromRow);
  }

  Selectable<BoardEntity> selectByName(String var1) {
    return customSelect('SELECT * FROM board_tb WHERE board_tb.name = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          boardTb,
        }).asyncMap(boardTb.mapFromRow);
  }

  Selectable<BoardEntity> searchBoard({required String query}) {
    return customSelect(
        'SELECT * FROM board_tb WHERE name LIKE CONCAT(\'%\', ?1, \'%\')',
        variables: [
          Variable<String>(query)
        ],
        readsFrom: {
          boardTb,
        }).asyncMap(boardTb.mapFromRow);
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(boardDao)
const boardDaoProvider = BoardDaoProvider._();

final class BoardDaoProvider
    extends $FunctionalProvider<BoardDao, BoardDao, BoardDao>
    with $Provider<BoardDao> {
  const BoardDaoProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'boardDaoProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$boardDaoHash();

  @$internal
  @override
  $ProviderElement<BoardDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoardDao create(Ref ref) {
    return boardDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardDao>(value),
    );
  }
}

String _$boardDaoHash() => r'23c19c12241fe850d29aad7c9ab3c2c430d10518';
