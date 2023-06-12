import 'package:isar/isar.dart';

import 'package:aac/model/communication_symbol.dart';

import 'model/board.dart';

class SymbolManager {
  SymbolManager({
    required this.isar,
  });

  final Isar isar;

  Future<void> saveSymbol(Id boardId, String label, String imagePath) async {
    await isar.writeTxn(() async {
      final CommunicationSymbol symbol =
          CommunicationSymbol(label: label, imagePath: imagePath);

      await isar.communicationSymbols.put(symbol);

      final childBoard = Board();
      await isar.boards.put(childBoard);
      symbol.childBoard.value = childBoard;
      await symbol.childBoard.save();

      final board = await isar.boards.get(boardId);

      if (board == null) return;

      symbol.parentBoard.add(board);
      symbol.parentBoard.save();
    });
  }

  Future<void> pinSymbolToBoard(CommunicationSymbol symbol, Board board) async {
    symbol.parentBoard.add(board);
    await isar.writeTxn(() => symbol.parentBoard.save());
  }

  Stream<List<CommunicationSymbol>> watchSymbols(Id boardId) async* {
    yield* isar.communicationSymbols
        .filter()
        .parentBoard((board) => board.idEqualTo(boardId))
        .watch(fireImmediately: true);
  }

  // Stream<Board> watchBoard() async* {
  //   final board = isar.boards.watchObject(1, fireImmediately: true);
  //   await for (final board in board) {
  //     print(board);
  //     if (board != null) {
  //       yield board;
  //     }
  //   }
  // }
}
