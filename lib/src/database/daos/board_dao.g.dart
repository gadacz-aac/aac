// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_dao.dart';

// ignore_for_file: type=lint
mixin _$BoardDaoMixin on DatabaseAccessor<AppDatabase> {
  Board get board => attachedDatabase.board;
  CommunicationSymbol get communicationSymbol =>
      attachedDatabase.communicationSymbol;
  ChildSymbol get childSymbol => attachedDatabase.childSymbol;
  Setting get setting => attachedDatabase.setting;
  Selectable<BoardEntity> selectById(int var1) {
    return customSelect('SELECT * FROM board WHERE board.id = ?1', variables: [
      Variable<int>(var1)
    ], readsFrom: {
      board,
    }).asyncMap(board.mapFromRow);
  }

  Selectable<BoardEntity> selectByName(String var1) {
    return customSelect('SELECT * FROM board WHERE board.name = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          board,
        }).asyncMap(board.mapFromRow);
  }

  Selectable<BoardEntity> searchBoard(String query) {
    return customSelect(
        'SELECT * FROM board WHERE name LIKE CONCAT(\'%\', ?1, \'%\')',
        variables: [
          Variable<String>(query)
        ],
        readsFrom: {
          board,
        }).asyncMap(board.mapFromRow);
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardDaoHash() => r'de349032985db8f86931dfb407fe7fbc89615a12';

/// See also [boardDao].
@ProviderFor(boardDao)
final boardDaoProvider = AutoDisposeProvider<BoardDao>.internal(
  boardDao,
  name: r'boardDaoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$boardDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BoardDaoRef = AutoDisposeProviderRef<BoardDao>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
