import 'dart:async';

import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_manager.g.dart';

@immutable
class BoardEditingParams {
  final int? id;
  final String name;
  final int? columnCount;
  final List<int> reorderedSymbols;

  const BoardEditingParams(
      {this.id,
      this.name = "",
      this.columnCount = 3,
      this.reorderedSymbols = const []});

  BoardEditingParams.fromBoard(BoardOld board)
      : this(
          name: board.name,
          id: board.id,
          columnCount: board.crossAxisCount,
          reorderedSymbols: board.reorderedSymbols,
        );

  BoardEditingParams copyWith(
      {int? id, String? name, int? columnCount, List<int>? reorderedSymbols}) {

    return BoardEditingParams(
        id: id ?? this.id,
        name: name ?? this.name,
        columnCount: columnCount ?? this.columnCount,
        reorderedSymbols: reorderedSymbols ?? this.reorderedSymbols);
  }

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

  SymbolEditingParams.fromSymbol(CommunicationSymbolOld symbol) 
      : imagePath = symbol.imagePath,
        label = symbol.label,
        color = symbol.color,
        vocalization = symbol.vocalization,
        isDeleted = symbol.isDeleted,
        childBoard = null 
    {
        throw UnimplementedError();
    }

  @override
  String toString() => "imagePath: $imagePath label: $label color: $color";
}

final symbolsProvider =
    StreamProvider.autoDispose<List<CommunicationSymbolOld>>((ref) {
  // final symbolManager = ref.watch(symbolManagerProvider);
  // return symbolManager.watchAllSymbols();
  throw UnimplementedError();
});

class SymbolManager {
  SymbolManager();

  Future<void> saveSymbol(int boardId, SymbolEditingParams params) async {
    // if (params.label == null) return;
    // if (params.imagePath == null) return;
    //
    // await isar.writeTxn(() async {
    //   final CommunicationSymbol symbol = CommunicationSymbol.fromParams(params);
    //
    //   await isar.communicationSymbols.put(symbol);
    //
    //   if (params.childBoard != null) {
    //     final childBoard = await _createOrUpdateChildBoard(params.childBoard!);
    //     _linkSymbolToBoard(symbol, childBoard);
    //   }
    //
    //   final board = await isar.boards.get(boardId);
    //
    //   if (board == null) return;
    //
    //   await _pinSymbolToBoard(symbol, board);
    //   // is needed to refersh ui
    //   isar.boards.put(board);
    // });


    throw UnimplementedError();
  }

  Future<void> updateSymbol(
      {required CommunicationSymbolOld symbol,
      required int parentBoardId,
      required SymbolEditingParams params}) async {
    // await isar.writeTxn(() async {
    //   final parentBoard = await isar.boards.get(parentBoardId);
    //   if (parentBoard == null) return;
    //
    //   await isar.communicationSymbols.put(symbol.updateWithParams(params));
    //
    //   if (params.childBoard != null) {
    //     final childBoard = await _createOrUpdateChildBoard(params.childBoard!);
    //     _linkSymbolToBoard(symbol, childBoard);
    //   } else {
    //     _unlinkSymbolFromBoard(symbol);
    //   }
    //
    //   isar.boards.put(parentBoard);
    // });
    //

    throw UnimplementedError();
  }

  Future<BoardOld> _createOrUpdateChildBoard(BoardEditingParams params) async {
    // final childBoard = Board.fromParams(params);
    // await isar.boards.put(childBoard);
    // return childBoard;
    //
    //
    throw UnimplementedError();
  }

  Future<CommunicationSymbolOld?> findSymbolByLabel(String label) async {
    // final symbol = await isar.communicationSymbols
    //     .filter()
    //     .labelEqualTo(label)
    //     .findFirst();
    // return symbol;
    //

    throw UnimplementedError();
  }

  Future<void> _linkSymbolToBoard(
      CommunicationSymbolOld symbol, BoardOld board) async {
    // symbol.childBoard.value = board;
    // await symbol.childBoard.save();
    //

    throw UnimplementedError();
  }

  Future<void> _unlinkSymbolFromBoard(CommunicationSymbolOld symbol) async {
    // symbol.childBoard.reset();
    // symbol.childBoard.save();
    //

    throw UnimplementedError();
  }

  Future<void> _pinSymbolToBoard(
      CommunicationSymbolOld symbol, BoardOld board) async {
    // board.symbols.add(symbol);
    // board.reorderedSymbols = [...board.reorderedSymbols, symbol.id];
    // board.symbols.save();
    //
    throw UnimplementedError();
  }

  Future<void> pinSymbolsToBoard(List<CommunicationSymbolOld> symbols,
      {BoardOld? board, int? boardId}) async {
    // await isar.writeTxn(() async {
    //   if (board == null && boardId != null) {
    //     board = await isar.boards.get(boardId);
    //   }
    //
    //   if (board == null) return;
    //
    //   final symbolsId = symbols.map((e) => e.id);
    //   board!.reorderedSymbols = [...board!.reorderedSymbols, ...symbolsId];
    //
    //   board!.symbols.addAll(symbols);
    //   await board!.symbols.save();
    //   await isar.boards.put(board!);
    // });

    throw UnimplementedError();
  }

  Future<void> unpinSymbolFromBoard(
      List<CommunicationSymbolOld> symbols, int boardId) async {
    // await isar.writeTxn(() async {
    //   final board = await isar.boards.get(boardId);
    //
    //   if (board == null) return;
    //   final symbolsId = symbols.map((e) => e.id);
    //   board.reorderedSymbols = [
    //     for (final e in board.reorderedSymbols)
    //       if (!symbolsId.contains(e)) e
    //   ];
    //   board.symbols.removeAll(symbols);
    //   await board.symbols.save();
    //   await isar.boards.put(board);
    // });

    throw UnimplementedError();
  }

  Future<void> unpinSymbolsFromEveryBoard(
      List<CommunicationSymbolOld> symbols) async {
    // await restoreSymbols(symbols);
    // for (var symbol in symbols) {
    //   try {
    //     await symbol.parentBoard.load();
    //
    //     await Future.wait(symbol.parentBoard
    //         .map((board) => unpinSymbolFromBoard([symbol], board.id)));
    //   } catch (e) {
    //     print('Błąd podczas odpinania symbolu $symbol: $e');
    //   }
    // }
    //

    throw UnimplementedError();
  }

  Future<Map<int, Set<int>>> _getReorderMap(
      Iterable<CommunicationSymbolOld> symbols) async {
    // await Future.wait(symbols.map((e) => e.parentBoard.load()));
    //
    // final reorderMap = <int, Set<int>>{};
    // for (final symbol in symbols) {
    //   for (final board in symbol.parentBoard) {
    //     reorderMap.update(board.id, (e) => e..add(symbol.id),
    //         ifAbsent: () => {symbol.id});
    //   }
    // }
    //
    // return reorderMap;

    throw UnimplementedError();
  }

  Future<void> moveSymbolToBin(
      List<CommunicationSymbolOld> symbols, bool deleteWithInsideSymbols) async {
    throw UnimplementedError();

    // final allSymbols = <CommunicationSymbol>{};
    // final visitedBoard = <int>{};
    //
    // Future<void> collectAllSymbols(CommunicationSymbol symbol) async {
    //   allSymbols.add(symbol);
    //   if (symbol.childBoard.value == null) return;
    //
    //   final childBoardId = symbol.childBoard.value!.id;
    //
    //   if (visitedBoard.contains(childBoardId)) return;
    //
    //   visitedBoard.add(childBoardId);
    //   final childBoard = await isar.boards.get(childBoardId);
    //   if (childBoard == null) return;
    //
    //   await Future.wait(childBoard.symbols.map(collectAllSymbols));
    // }
    //
    // if (deleteWithInsideSymbols) {
    //   await Future.wait(symbols.map(collectAllSymbols));
    // } else {
    //   allSymbols.addAll(symbols);
    // }
    //
    // final reorderMap = await _getReorderMap(allSymbols);
    //
    // await isar.writeTxn(() async {
    //   for (final symbol in allSymbols) {
    //     await isar.communicationSymbols.put(symbol
    //         .updateWithParams(const SymbolEditingParams(isDeleted: true)));
    //   }
    //
    //   for (final entry in reorderMap.entries) {
    //     final board = await isar.boards.get(entry.key);
    //
    //     if (board == null) continue;
    //     board.reorderedSymbols = [
    //       for (final e in board.reorderedSymbols)
    //         if (!entry.value.contains(e)) e
    //     ];
    //
    //     isar.boards.put(board);
    //   }
    // });
  }

  Future<void> restoreSymbols(List<CommunicationSymbolOld> symbols) async {
    // final reorderMap = await _getReorderMap(symbols);
    //
    // await isar.writeTxn(() async {
    //   for (var symbol in symbols) {
    //     await isar.communicationSymbols.put(symbol
    //         .updateWithParams(const SymbolEditingParams(isDeleted: false)));
    //   }
    //
    //   for (final entry in reorderMap.entries) {
    //     final board = await isar.boards.get(entry.key);
    //
    //     if (board == null) continue;
    //     board.reorderedSymbols = [...board.reorderedSymbols, ...entry.value];
    //
    //     isar.boards.put(board);
    //   }
    // });
    throw UnimplementedError();
  }

  Future<void> deleteSymbols(List<CommunicationSymbolOld> symbols) async {
    // await isar.writeTxn(() async {
    //   for (var symbol in symbols) {
    //     await isar.communicationSymbols.delete(symbol.id);
    //   }
    // });
  throw UnimplementedError();
  }

  // TODO chyba tylko w śmietniku to można odrazu zwracać symbole usunięte
  Stream<List<CommunicationSymbolOld>> watchAllSymbols() async* {
    // yield* isar.communicationSymbols
    //     .where()
    //     .watch(fireImmediately: true)
    //     .asyncMap((_) async => await isar.communicationSymbols
    //         .where()
    //         .findAll()); // TODO ????????????????
    //
    throw UnimplementedError();
  }
}

@riverpod
SymbolManager symbolManager(SymbolManagerRef ref) {
  // final isar = ref.watch(isarProvider);
  // return SymbolManager(isar: isar);
  throw UnimplementedError();
}
