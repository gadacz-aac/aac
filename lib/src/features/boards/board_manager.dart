import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_manager.g.dart';

final boardProvider =
    StreamProvider.autoDispose.family<BoardOld?, int>((ref, id) async* {
  final dao = ref.watch(boardDaoProvider);
  yield* dao.watchById(id);
});

@riverpod
BoardManager boardManager(Ref ref) {
  return BoardManager();
}

class BoardManager {
  BoardManager();
  Future<BoardOld> createOrUpdate(BoardEditingParams params) async {
    // final board = Board.fromParams(params);
    // isar.writeTxn(() async {
    //   await isar.boards.put(board);
    // });
    //
    // return board;
    throw UnimplementedError();
  }

  Future<BoardOld?> findBoardByName(String name) async {
    // final board = await isar.boards.where().filter().nameEqualTo(name).findFirst();
    // return board;
    throw UnimplementedError();
  }

  Stream<BoardOld?> watchBoardById(int id) async* {
    // yield* isar.boards.watchObject(id, fireImmediately: true);
    throw UnimplementedError();
  }
}
