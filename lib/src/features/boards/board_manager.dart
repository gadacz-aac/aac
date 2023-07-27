import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

class BoardManager {
  BoardManager({
    required this.isar,
  });

  final Isar isar;

  Stream<Board?> watchBoardById(Id id) async* {
    yield* isar.boards.watchObject(id, fireImmediately: true);
  }
}

final boardProvider =
    StreamProvider.autoDispose.family<Board?, Id>((ref, id) async* {
  final manager = ref.watch(boardManagerProvider);
  yield* manager.watchBoardById(id);
});
