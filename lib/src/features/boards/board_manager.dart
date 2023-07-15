import 'package:aac/src/features/boards/model/board.dart';
import 'package:isar/isar.dart';

class BoardManager {
  BoardManager({
    required this.isar,
  });

  final Isar isar;

  Future<int> getCrossAxisCount(Id boardId) async {
    final board = await isar.boards.get(boardId);
    return board?.crossAxisCount ?? 2;
  }
}
