import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/database/daos/child_communication_symbol_dao.dart';
import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bin_manager.g.dart';

@riverpod
BinManager binManager(Ref ref) {
  final db = ref.watch(dbProvider);
  final boardDao = ref.watch(boardDaoProvider);
  final symbolDao = ref.watch(symbolDaoProvider);
  final childSymbolDao = ref.watch(childSymbolDaoProvider);

  return BinManager(
      db: db,
      symbolDao: symbolDao,
      boardDao: boardDao,
      childSymbolDao: childSymbolDao);
}

class BinManager {
  final AppDatabase db;
  final SymbolDao symbolDao;
  final BoardDao boardDao;
  ChildSymbolDao childSymbolDao;

  BinManager(
      {required this.db,
      required this.symbolDao,
      required this.boardDao,
      required this.childSymbolDao});

  Future<void> _moveSymbolToBin(Iterable<int> symbolIds) {
    return Future.wait(symbolIds.map(symbolDao.markAsDeleted));
  }

  Future<void> moveSymbolToBin(List<CommunicationSymbol> symbols) {
    final hasChild = symbols.any((e) => e.childBoardId != null);

    if (hasChild) {
      print(
          "co najmniej jeden symbol jest połączony z tablicą. ona nie zostanie suunięta jeśli chcesz ją usuńąc przejść do ekranu zarządzania tablicami");
    }

    return db.transaction(() async {
      await _moveSymbolToBin(symbols.map((e) => e.id));
    });
  }

  Future<void> _restoreSymbols(Iterable<int> symbolIds) {
    return Future.wait(symbolIds.map(symbolDao.restoreSymbol));
  }

  Future<void> restoreSymbols(List<CommunicationSymbol> symbols) {
    return db.transaction(() async {
      await _restoreSymbols(symbols.map((e) => e.id));
    });
  }

  Future<void> _deleteSymbols(Iterable<int> symbolIds) {
    return Future.wait(symbolIds.map(symbolDao.deletePermanently));
  }

  Future<void> deleteSymbols(List<CommunicationSymbol> symbols) {
    return db.transaction(() async {
      await _deleteSymbols(symbols.map((e) => e.id));
    });
  }

  Future<void> boardMoveToTrash(int id, Iterable<int> symbolIds) async {
    if (id == 1) {
      return;
    }

    return db.transaction(() async {
      await boardDao.toggleIsDeleted(id);
      await _moveSymbolToBin(symbolIds);
      await childSymbolDao.removeLinksToParent(id);
    });
  }

  Future<void> boardRestoreFromTrash(int id, Iterable<int> symbolIds) {
    return db.transaction(() async {
      await boardDao.toggleIsDeleted(id);
      await _restoreSymbols(symbolIds);
    });
  }

  Future<void> boardDeletePermanently(int id, Iterable<int> symbolIds) {
    return db.transaction(() async {
      await db.managers.boardTb.filter((f) => f.id(id)).delete();
      await _deleteSymbols(symbolIds);
    });
  }
}
