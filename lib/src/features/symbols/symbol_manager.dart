import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../shared/isar_provider.dart';

@immutable
class BoardEditingParams {
  final String? name;
  final int? columnCount;
  final int? rowCount;

  const BoardEditingParams({this.name, this.columnCount, this.rowCount});
  BoardEditingParams.fromBoard(Board board)
      : name = board.name,
        columnCount = board.crossAxisCount,
        rowCount = null;

  @override
  String toString() =>
      "name: $name columnCount: $columnCount rowCount: $rowCount";
}

@immutable
class SymbolEditingParams {
  final String? imagePath;
  final String? label;
  final int? color;
  final BoardEditingParams? childBoard;

  const SymbolEditingParams({
    this.imagePath,
    this.label,
    this.color,
    this.childBoard,
  });

  SymbolEditingParams.fromSymbol(CommunicationSymbol symbol)
      : imagePath = symbol.imagePath,
        label = symbol.label,
        color = symbol.color,
        childBoard = symbol.childBoard.value != null
            ? BoardEditingParams.fromBoard(symbol.childBoard.value!)
            : null;

  @override
  String toString() => "imagePath: $imagePath label: $label color: $color";
}

class SymbolManager {
  SymbolManager({
    required this.isar,
  });

  final Isar isar;

  Future<void> saveSymbol(Id boardId, SymbolEditingParams params) async {
    if (params.label == null) return;
    if (params.imagePath == null) return;

    await isar.writeTxn(() async {
      final CommunicationSymbol symbol = CommunicationSymbol.fromParams(params);

      await isar.communicationSymbols.put(symbol);

      if (params.childBoard != null) {
        final childBoard = await _createChildBoard(params.childBoard!);
        _linkSymbolToBoard(symbol, childBoard);
      }

      final board = await isar.boards.get(boardId);

      if (board == null) return;

      await _pinSymbolToBoard(symbol, board);
      // is needed to refersh ui
      isar.boards.put(board);
    });
  }

  Future<void> updateSymbol(
      {required CommunicationSymbol symbol,
      required Id parentBoardId,
      required SymbolEditingParams params}) async {
    await isar.writeTxn(() async {
      final parentBoard = await isar.boards.get(parentBoardId);
      if (parentBoard == null) return;

      await isar.communicationSymbols.put(symbol.updateWithParams(params));

      if (params.childBoard != null) {
        final childBoard = await _createChildBoard(params.childBoard!);
        _linkSymbolToBoard(symbol, childBoard);
      } else {
        _unlinkSymbolFromBoard(symbol);
      }

      isar.boards.put(parentBoard);
    });
  }

  Future<void> _linkSymbolToBoard(
      CommunicationSymbol symbol, Board board) async {
    symbol.childBoard.value = board;
    await symbol.childBoard.save();
  }

  Future<void> _unlinkSymbolFromBoard(CommunicationSymbol symbol) async {
    symbol.childBoard.reset();
    symbol.childBoard.save();
  }

  Future<void> _pinSymbolToBoard(
      CommunicationSymbol symbol, Board board) async {
    board.symbols.add(symbol);
    board.symbols.save();
  }

  Future<void> pinSymbolsToBoard(
      List<CommunicationSymbol> symbols, Board board) async {
    await isar.writeTxn(() async {
      board.symbols.addAll(symbols);
      await board.symbols.save();
      await isar.boards.put(board);
    });
  }

  Future<void> unpinSymbolFromBoard(
      List<CommunicationSymbol> symbols, Id boardId) async {
    await isar.writeTxn(() async {
      final board = await isar.boards.get(boardId);

      if (board == null) return;
      board.symbols.removeAll(symbols);
      await board.symbols.save();
      await isar.boards.put(board);
    });
  }

  Future<void> deleteSymbol(
      List<CommunicationSymbol> symbols, Id boardId) async {
    final symbolIds = symbols.map((e) => e.id).toList();
    await isar.writeTxn(() async {
      final board = await isar.boards.get(boardId);
      if (board == null) return;
      await isar.communicationSymbols.deleteAll(symbolIds);
      await isar.boards.put(board);
    });
  }

  Future<Board> _createChildBoard(BoardEditingParams childBoardParams) async {
    final childBoard = Board(
        name: childBoardParams.name!,
        crossAxisCountOrNull: childBoardParams.columnCount!);
    await isar.boards.put(childBoard);
    return childBoard;
  }
}

final symbolManagerProvider = Provider<SymbolManager>((ref) {
  final isar = ref.watch(isarPod);
  return SymbolManager(isar: isar);
});
