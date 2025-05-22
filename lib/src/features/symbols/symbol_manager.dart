import 'dart:async';

import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_manager.g.dart';

@immutable
class BoardEditingParams {
  final int? id;
  final String name;
  final int? columnCount;

  const BoardEditingParams({this.id, this.name = "", this.columnCount = 3});

  BoardEditingParams.fromBoard(BoardOld board)
      : this(name: board.name, id: board.id, columnCount: board.crossAxisCount);

  BoardEditingParams copyWith({int? id, String? name, int? columnCount}) {
    return BoardEditingParams(
        id: id ?? this.id,
        name: name ?? this.name,
        columnCount: columnCount ?? this.columnCount);
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
  final int? childBoardId;
  final int? id;

  const SymbolEditingParams(
      {this.imagePath,
      this.label,
      this.vocalization,
      this.isDeleted,
      this.color,
      this.childBoardId,
      this.id});

  SymbolEditingParams.fromSymbol(CommunicationSymbolOld symbol)
      : imagePath = symbol.imagePath,
        label = symbol.label,
        color = symbol.color,
        vocalization = symbol.vocalization,
        isDeleted = symbol.isDeleted,
        childBoardId = symbol.childBoardId,
        id = symbol.id;

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
  final AppDatabase db;
  final SymbolDao symbolDao;

  SymbolManager(this.db, this.symbolDao);

  Future<void> saveSymbol(int boardId, SymbolEditingParams params,
      [BoardEditingParams? boardParams]) async {
    if (params.label == null) return;
    if (params.imagePath == null) return;

    await db.transaction(() async {
      int? childBoardId;

      if (boardParams != null) {
        childBoardId = await createOrUpdateChildBoard(boardParams);
      }

      final symbolId = await db.managers.communicationSymbol.create((o) => o(
          label: params.label ?? "",
          color: Value(params.color),
          imagePath: params.imagePath ?? "",
          isDeleted: Value.absentIfNull(params.isDeleted),
          vocalization: Value.absentIfNull(params.vocalization),
          childBoardId: Value.absentIfNull(childBoardId)));

      await symbolDao.pinSymbolToBoard(boardId, symbolId);
    });
  }

  Future<void> updateSymbol(int parentBoardId, SymbolEditingParams params,
      [BoardEditingParams? boardParams]) async {
    await db.transaction(() async {
      int? childBoardId = boardParams?.id;

      if (boardParams != null) {
        childBoardId = await createOrUpdateChildBoard(boardParams);
      }

      var cs = await db.managers.communicationSymbol
          .filter((f) => f.id(params.id))
          .getSingle();

      cs = cs.copyWithCompanion(CommunicationSymbolCompanion(
          color: Value.absentIfNull(params.color),
          label: Value.absentIfNull(params.label),
          imagePath: Value.absentIfNull(params.imagePath),
          isDeleted: Value.absentIfNull(params.isDeleted),
          childBoardId: Value(childBoardId),
          vocalization: Value.absentIfNull(params.vocalization)));

      await db.managers.communicationSymbol.replace(cs);
    });
  }

  Future<int> createOrUpdateChildBoard(BoardEditingParams boardParams) {
    return db.managers.board.create(
        (o) => o(
            id: Value.absentIfNull(boardParams.id),
            name: boardParams.name,
            crossAxisCount: Value(boardParams.columnCount ?? 3)),
        mode: InsertMode.replace);
  }

  Future<CommunicationSymbolOld?> findSymbolByLabel(String label) {
    return db.managers.communicationSymbol
        .filter((f) => f.label(label))
        .map(CommunicationSymbolOld.fromEntity)
        .getSingleOrNull();
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

  Future<void> pinSymbolsToBoard(
      int boardId, List<CommunicationSymbolOld> symbols) async {
    db.transaction(() async {
      for (var s in symbols) {
        await symbolDao.pinSymbolToBoard(boardId, s.id);
      }
    });
  }

  Future<void> unpinSymbolFromBoard(
      List<CommunicationSymbolOld> symbols, int boardId) async {
    final symbolIds = symbols.map((e) => e.id);
    await db.managers.childSymbol
        .filter((f) => f.boardId.id(boardId) & f.symbolId.id.isIn(symbolIds))
        .delete();
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

  Future<void> moveSymbolToBin(List<CommunicationSymbolOld> symbols) async {
    return db.transaction(() async {
      await Future.wait(symbols.map((e) => e.id).map(symbolDao.markAsDeleted));
    });
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
    return db.transaction(() async {
      await Future.wait(symbols.map((e) => e.id).map(symbolDao.deletePermanently));
    });
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
SymbolManager symbolManager(Ref ref) {
  final db = ref.watch(dbProvider);
  final symbolDao = ref.watch(symbolDaoProvider);
  return SymbolManager(db, symbolDao);
}
