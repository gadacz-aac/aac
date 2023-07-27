import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../shared/isar_provider.dart';

class SymbolManager {
  SymbolManager({
    required this.isar,
  });

  final Isar isar;

  Future<void> saveSymbol(Id boardId,
      {required String label,
      required String imagePath,
      int? crossAxisCount,
      bool createChild = false}) async {
    await isar.writeTxn(() async {
      final CommunicationSymbol symbol =
          CommunicationSymbol(label: label, imagePath: imagePath);

      await isar.communicationSymbols.put(symbol);
      if (createChild) {
        final childBoard = Board(crossAxisCountOrNull: crossAxisCount);
        await isar.boards.put(childBoard);
        _linkSymbolToBoard(symbol, childBoard);
      }

      final board = await isar.boards.get(boardId);

      if (board == null) return;

      await _pinSymbolToBoard(symbol, board);
      // is needed to refersh ui
      isar.boards.put(board);
    });
  }

  Future<void> _linkSymbolToBoard(
      CommunicationSymbol symbol, Board board) async {
    symbol.childBoard.value = board;
    await symbol.childBoard.save();
  }

  Future<void> _pinSymbolToBoard(
      CommunicationSymbol symbol, Board board) async {
    board.symbols.add(symbol);
    board.symbols.save();
  }

  Future<void> unpinSymbolFromBoard(
      CommunicationSymbol symbol, Board board) async {
    board.symbols.remove(symbol);
    await isar.writeTxn(() async {
      await board.symbols.save();
      await isar.boards.put(board);
    });
  }

  Future<void> deleteSymbol(CommunicationSymbol symbol, Board board) async {
    await isar.writeTxn(() async {
      await isar.communicationSymbols.delete(symbol.id);
      await isar.boards.put(board);
    });
  }
}

final symbolManagerProvider = Provider<SymbolManager>((ref) {
  final isar = ref.watch(isarPod);
  return SymbolManager(isar: isar);
});
