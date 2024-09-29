import 'dart:async';

import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/isar_provider.dart';

part 'symbol_manager.g.dart';

@immutable
class BoardEditingParams {
  final Id? id;
  final String name;
  final int? columnCount;
  final List<int> reorderedSymbols;

  const BoardEditingParams({this.id, this.name = "", this.columnCount = 3, this.reorderedSymbols = const []});

  BoardEditingParams.fromBoard(Board board)
      : this(
          name: board.name,
          id: board.id,
          columnCount: board.crossAxisCount,
          reorderedSymbols: board.reorderedSymbols,
        );

  @override
  String toString() => "name: $name id: $id columnCount: $columnCount";
}

@immutable
class SymbolEditingParams {
  final String? imagePath;
  final String? label;
  final String? vocalization;
  final bool? isDeleted;
  final int? color;
  final BoardEditingParams? childBoard;

  const SymbolEditingParams(
      {this.imagePath,
      this.label,
      this.vocalization,
      this.isDeleted,
      this.color,
      this.childBoard});

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

final symbolsProvider =
    StreamProvider.autoDispose<List<CommunicationSymbol>>((ref) {
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

  Future<Board> _createOrUpdateChildBoard(BoardEditingParams params) async {
    final childBoard = Board.fromParams(params);
    await isar.boards.put(childBoard);
    return childBoard;
  
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
    board.reorderedSymbols = [...board.reorderedSymbols, symbol.id];
    board.symbols.save();
  }

  Future<void> pinSymbolsToBoard(
      List<CommunicationSymbol> symbols, {Board? board, Id? boardId}) async {
    await isar.writeTxn(() async {
      if (board == null && boardId != null) {
        board = await isar.boards.get(boardId);
      }
      if (board == null) return;

      final symbolsId = symbols.map((e) => e.id);
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
      final symbolsId = symbols.map((e) => e.id);
      board.reorderedSymbols = [
        for (final e in board.reorderedSymbols)
          if (!symbolsId.contains(e)) e
      ];
      board.symbols.removeAll(symbols);
      await board.symbols.save();
      await isar.boards.put(board);
    });
  }

  Future<void> unpinSymbolsFromEveryBoard(
      List<CommunicationSymbol> symbols) async {
    await restoreSymbols(symbols);
    for (var symbol in symbols) {
      try {
        await symbol.parentBoard.load();

        await Future.wait(symbol.parentBoard
            .map((board) => unpinSymbolFromBoard([symbol], board.id)));
      } catch (e) {
        print('Błąd podczas odpinania symbolu $symbol: $e');
      }
    }
  }

  Future<Map<int, Set<int>>> _getReorderMap(
      Iterable<CommunicationSymbol> symbols) async {
    await Future.wait(symbols.map((e) => e.parentBoard.load()));

    final reorderMap = <int, Set<int>>{};
    for (final symbol in symbols) {
      for (final board in symbol.parentBoard) {
        reorderMap.update(board.id, (e) => e..add(symbol.id),
            ifAbsent: () => {symbol.id});
      }
    }

    return reorderMap;
  }

  Future<void> moveSymbolToBin(
      List<CommunicationSymbol> symbols, bool deleteWithInsideSymbols) async {
    final allSymbols = <CommunicationSymbol>{};

    Future<void> collectAllSymbols(CommunicationSymbol symbol) async {
      allSymbols.add(symbol);
      if (symbol.childBoard.value == null) return;

      final childBoardId = symbol.childBoard.value!.id;
      final childBoard = await isar.boards.get(childBoardId);
      if (childBoard == null) return;

      await Future.wait(childBoard.symbols.map(collectAllSymbols));
    }

    if (deleteWithInsideSymbols) {
      await Future.wait(symbols.map(collectAllSymbols));
    } else {
      allSymbols.addAll(symbols);
    }

    final reorderMap = await _getReorderMap(allSymbols);

    await isar.writeTxn(() async {
      for (final symbol in allSymbols) {
        await isar.communicationSymbols.put(symbol
            .updateWithParams(const SymbolEditingParams(isDeleted: true)));
      }

      for (final entry in reorderMap.entries) {
        final board = await isar.boards.get(entry.key);

        if (board == null) continue;
        board.reorderedSymbols = [
          for (final e in board.reorderedSymbols)
            if (!entry.value.contains(e)) e
        ];

        isar.boards.put(board);
      }
    });
  }

  Future<void> restoreSymbols(List<CommunicationSymbol> symbols) async {
    final reorderMap = await _getReorderMap(symbols);

    await isar.writeTxn(() async {
      for (var symbol in symbols) {
        await isar.communicationSymbols.put(symbol
            .updateWithParams(const SymbolEditingParams(isDeleted: false)));
      }

      for (final entry in reorderMap.entries) {
        final board = await isar.boards.get(entry.key);

        if (board == null) continue;
        board.reorderedSymbols = [...board.reorderedSymbols, ...entry.value];

        isar.boards.put(board);
      }
    });
  }

  Future<void> deleteSymbols(List<CommunicationSymbol> symbols) async {
    await isar.writeTxn(() async {
      for (var symbol in symbols) {
        await isar.communicationSymbols.delete(symbol.id);
      }
    });
  }

  // TODO chyba tylko w śmietniku to można odrazu zwracać symbole usunięte
  Stream<List<CommunicationSymbol>> watchAllSymbols() async* {
    yield* isar.communicationSymbols
        .where()
        .watch(fireImmediately: true)
        .asyncMap((_) async => await isar.communicationSymbols
            .where()
            .findAll()); // TODO ????????????????
  }
}

@riverpod
SymbolManager symbolManager(SymbolManagerRef ref) {
  final isar = ref.watch(isarProvider);
  return SymbolManager(isar: isar);
}
