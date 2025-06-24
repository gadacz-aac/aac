import 'dart:async';

import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_board_association_manager.g.dart';

class SymbolBoardAssociationManager {
  final AppDatabase db;
  final SymbolDao symbolDao;

  SymbolBoardAssociationManager(this.db, this.symbolDao);

  Future<void> pin(int boardId, List<CommunicationSymbol> symbols) async {
    db.transaction(() async {
      for (var s in symbols) {
        await symbolDao.pinSymbolToBoard(boardId, s.id);
      }
    });
  }

  Future<void> unpin(List<CommunicationSymbol> symbols, int? boardId) async {
    return symbolDao.unpinSymbols(symbols, boardId);
  }
}

@riverpod
SymbolBoardAssociationManager symbolBoardAssociationManager(Ref ref) {
  final db = ref.watch(dbProvider);
  final symbolDao = ref.watch(symbolDaoProvider);

  return SymbolBoardAssociationManager(db, symbolDao);
}
