import 'package:aac/src/features/boards/model/board.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/isar_provider.dart';

part 'board_manager.g.dart';

final boardProvider =
    StreamProvider.autoDispose.family<Board?, Id>((ref, id) async* {
  final manager = ref.watch(boardManagerProvider);
  yield* manager.watchBoardById(id);
});

@riverpod
BoardManager boardManager(BoardManagerRef ref) {
  final isar = ref.watch(isarProvider);
  return BoardManager(isar: isar);
}

class BoardManager {
  final Isar isar;

  BoardManager({
    required this.isar,
  });

  Stream<Board?> watchBoardById(Id id) async* {
    yield* isar.boards.watchObject(id, fireImmediately: true);
  }
}
