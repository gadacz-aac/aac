import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/isar_provider.dart';
part 'symbol_manager.g.dart';

@immutable
class BoardEditingParams {
  final Id? id;
  final String name;
  final int? columnCount;

  const BoardEditingParams(
      {this.id, this.name = "", this.columnCount = 3});

  BoardEditingParams.fromBoard(Board board)
      : this(
            name: board.name,
            id: board.id,
            columnCount: board.crossAxisCount,);

  @override
  String toString() =>
      "name: $name id: $id columnCount: $columnCount";
}

@immutable
class SymbolEditingParams {
  final String? imagePath;
  final String? label;
  final String? vocalization;
  final int? color;
  final BoardEditingParams? childBoard;

  const SymbolEditingParams({
    this.imagePath,
    this.label,
    this.color,
    this.vocalization,
    this.childBoard,
  });

  SymbolEditingParams.fromSymbol(CommunicationSymbol symbol)
      : imagePath = symbol.imagePath,
        label = symbol.label,
        color = symbol.color,
        vocalization = symbol.vocalization,
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
        final childBoard = await _createOrUpdateChildBoard(params.childBoard!);
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
        final childBoard = await _createOrUpdateChildBoard(params.childBoard!);
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
    board.reorderedSymbols = [...board.reorderedSymbols, symbol.id];
    board.symbols.save();
  }

  Future<void> pinSymbolsToBoard(
      List<CommunicationSymbol> symbols, int boardId) async {
    await isar.writeTxn(() async {
      final board = await isar.boards.get(boardId);

      if (board == null) return;

      final symbolsId = symbols.map((e)=>e.id);
      board.reorderedSymbols = [...board.reorderedSymbols, ...symbolsId];

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
      final symbolsId = symbols.map((e)=>e.id);
      board.reorderedSymbols = [
        for (final e in board.reorderedSymbols)
          if (!symbolsId.contains(e)) e
      ];
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
      final symbolsId = symbols.map((e)=>e.id);
      board.reorderedSymbols = [
        for (final e in board.reorderedSymbols)
          if (!symbolsId.contains(e)) e
      ];
      await isar.communicationSymbols.deleteAll(symbolIds);
      await isar.boards.put(board);
    });
  }

  Future<Board> _createOrUpdateChildBoard(BoardEditingParams params) async {
    final childBoard = Board.fromParams(params);
    await isar.boards.put(childBoard);
    return childBoard;
  }
}

@riverpod
SymbolManager symbolManager(SymbolManagerRef ref) {
  final isar = ref.watch(isarProvider);
  return SymbolManager(isar: isar);
}
