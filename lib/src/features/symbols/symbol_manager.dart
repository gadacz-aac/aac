import 'dart:async';

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
  final bool? isDeleted;
  final int? color;
  final BoardEditingParams? childBoard;

  const SymbolEditingParams({
    this.imagePath,
    this.label,
    this.vocalization,
    this.isDeleted,
    this.color,
    this.childBoard
  });

  SymbolEditingParams.fromSymbol(CommunicationSymbol symbol)
      : imagePath = symbol.imagePath,
        label = symbol.label,
        color = symbol.color,
        vocalization = symbol.vocalization,
        isDeleted = symbol.isDeleted,
        childBoard = symbol.childBoard.value != null
            ? BoardEditingParams.fromBoard(symbol.childBoard.value!)
            : null;

  @override
  String toString() => "imagePath: $imagePath label: $label color: $color";
}

final symbolsProvider = StreamProvider.autoDispose<List<CommunicationSymbol>>((ref) {
  final symbolManager = ref.watch(symbolManagerProvider);
  return symbolManager.watchAllSymbols();
});

class SymbolManager {
  final Isar isar;

  SymbolManager({
    required this.isar,
  });


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

  Future<CommunicationSymbol?> findSymbolByLabel(String label) async {
    final symbol = await isar.communicationSymbols.filter().labelEqualTo(label).findFirst();
    return symbol;
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
      List<CommunicationSymbol> symbols, {Board? board, Id? boardId}) async {
    if (board == null && boardId != null) {
      board = await isar.boards.get(boardId);
    }
    if (board == null) return;
    
    await isar.writeTxn(() async {
      board?.symbols.addAll(symbols);
      await board?.symbols.save();
      await isar.boards.put(board!);
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


  Future<void> unpinSymbolsFromEveryBoard(List<CommunicationSymbol> symbols) async {
    await restoreSymbols(symbols);
      for (var symbol in symbols) {
        try {
          final boards = await _getAllParentBoards(symbol);
          await Future.wait(
            boards.map((board) => unpinSymbolFromBoard([symbol], board.id))
          );
        } catch (e) {
          print('Błąd podczas odpinania symbolu $symbol: $e');
        }
      }
  }

  Future<void> moveSymbolToBin(List<CommunicationSymbol> symbols, bool deleteWithInsideSymbols) async {
    final symbolIds = symbols.map((e) => e.id).toList();
    final allSymbolIds = <Id>{};

    Future<void> collectAllSymbols(Id symbolId) async {
      final symbol = await isar.communicationSymbols.get(symbolId);
      if (symbol == null) return;
      allSymbolIds.add(symbolId);
      if (symbol.childBoard.value != null) {
        final childBoardId = symbol.childBoard.value!.id;
        final childBoard = await isar.boards.get(childBoardId);
        if (childBoard != null) {
          for (var childSymbol in childBoard.symbols) {
            await collectAllSymbols(childSymbol.id);
          }
        }
      }
    }

    if (deleteWithInsideSymbols){
      for (var symbolId in symbolIds) {
        await collectAllSymbols(symbolId);
      }
    } else {
      allSymbolIds.addAll(symbolIds);
    }


    await Future.wait(allSymbolIds.map((symbolId) async {
      await isar.writeTxn(() async {
        final symbol = await isar.communicationSymbols.get(symbolId);
        if (symbol == null) return;
        await isar.communicationSymbols.put(symbol.updateWithParams(const SymbolEditingParams(isDeleted: true)));
      });
    }));

    await updateAllBoards();

    await isar.writeTxn(() async {
      final symbols = await isar.communicationSymbols.where().findAll();
      await isar.communicationSymbols.putAll(symbols);
    });
  }

  Future<void> updateAllBoards() async {
    await isar.writeTxn(() async {
      final allBoards = await isar.boards.where().findAll();
      if (allBoards.isEmpty) return;
      await isar.boards.putAll(allBoards);
    });
  }

  Future<void> restoreSymbols(List<CommunicationSymbol> symbols) async {
    for (var symbol in symbols) {
      await isar.writeTxn(() async {
        await isar.communicationSymbols.put(symbol.updateWithParams(const SymbolEditingParams(isDeleted: false)));
      });
    }
    await updateAllBoards();
  }

  Future<void> deleteSymbols(List<CommunicationSymbol> symbols) async {
    await isar.writeTxn(() async {
      for (var symbol in symbols) {
        await isar.communicationSymbols.delete(symbol.id);
      }
    });
    updateAllBoards();
  }

  Future<Board> _createOrUpdateChildBoard(BoardEditingParams params) async {
    final childBoard = Board.fromParams(params);
    await isar.boards.put(childBoard);
    return childBoard;
  }

  Future<List<Board>> _getAllParentBoards(CommunicationSymbol symbol) async {
    await symbol.parentBoard.load();
    return symbol.parentBoard.toList();
  }

  Stream<List<CommunicationSymbol>> watchAllSymbols() async* {
    yield* isar.communicationSymbols
      .where()
      .watch(fireImmediately: true)
      .asyncMap((_) async => await isar.communicationSymbols.where().findAll());
  }
}

@riverpod
SymbolManager symbolManager(SymbolManagerRef ref) {
  final isar = ref.watch(isarProvider);
  return SymbolManager(isar: isar);
}