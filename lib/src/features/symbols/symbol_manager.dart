import 'dart:async';

import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_manager.g.dart';

@immutable
class BoardEditModel {
  final int? id;
  final String name;
  final int? columnCount;

  const BoardEditModel({this.id, this.name = "", this.columnCount = 3});

  BoardEditModel.fromBoard(Board board)
      : this(name: board.name, id: board.id, columnCount: board.crossAxisCount);

  BoardEditModel copyWith({int? id, String? name, int? columnCount}) {
    return BoardEditModel(
        id: id ?? this.id,
        name: name ?? this.name,
        columnCount: columnCount ?? this.columnCount);
  }

  @override
  String toString() => "name: $name id: $id columnCount: $columnCount";
}

@immutable
class SymbolEditModel {
  final String? imagePath;
  final String? label;
  final String? vocalization;
  final bool? isDeleted;
  final int? color;
  final int? childBoardId;
  final int? id;

  const SymbolEditModel(
      {this.imagePath,
      this.label,
      this.vocalization,
      this.isDeleted,
      this.color,
      this.childBoardId,
      this.id});

  SymbolEditModel.fromSymbol(CommunicationSymbol symbol)
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

class SymbolManager {
  final AppDatabase db;
  final SymbolDao symbolDao;
  final BoardDao boardDao;

  SymbolManager(this.db, this.symbolDao, this.boardDao);

  Future<int> saveSymbol(int boardId, SymbolEditModel params,
      [BoardEditModel? childBoard]) async {
    if (params.label == null) {
      throw ArgumentError.notNull("Label must not be null");
    }

    if (params.imagePath == null) {
      throw ArgumentError.notNull("Image path must not be null");
    }

    return await db.transaction(() async {
      int? childBoardId;

      if (childBoard != null) {
        childBoardId = await boardDao.createOrUpdateChildBoard(childBoard);
      }

      final symbolId = await symbolDao.create(params, childBoardId);

      await symbolDao.pinSymbolToBoard(boardId, symbolId);

      return symbolId;
    });
  }

  Future<void> updateSymbol(int boardId, SymbolEditModel params,
      [BoardEditModel? childBoard]) async {
    await db.transaction(() async {
      int? childBoardId = childBoard?.id;

      if (childBoard != null) {
        childBoardId = await boardDao.createOrUpdateChildBoard(childBoard);
      }

      await symbolDao.updateWith(params, childBoardId);
    });
  }

  Future<CommunicationSymbol?> findSymbolByLabel(String label) {
    return symbolDao.findByLabel(label);
  }

  Future<void> moveSymbolToBin(List<CommunicationSymbol> symbols) {
    return db.transaction(() async {
      await Future.wait(symbols.map((e) => e.id).map(symbolDao.markAsDeleted));
    });
  }

  Future<void> restoreSymbols(List<CommunicationSymbol> symbols) {
    return db.transaction(() async {
      await Future.wait(symbols.map((e) => e.id).map(symbolDao.restoreSymbol));
    });
  }

  Future<void> deleteSymbols(List<CommunicationSymbol> symbols) {
    return db.transaction(() async {
      await Future.wait(
          symbols.map((e) => e.id).map(symbolDao.deletePermanently));
    });
  }
}

@riverpod
SymbolManager symbolManager(Ref ref) {
  final db = ref.watch(dbProvider);
  final symbolDao = ref.watch(symbolDaoProvider);
  final boardDao = ref.watch(boardDaoProvider);

  return SymbolManager(db, symbolDao, boardDao);
}
