import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/symbol_search_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Stream<List<CommunicationSymbol>> searchedSymbol(Ref ref) async* {
  final query = ref.watch(localQueryProvider);

  final color = ref.watch(symbolSearchColorFilterProvider)?.code;
  final onlyPinned = ref.watch(symbolSearchOnlyPinnedFilterProvider);

  // watched, so results update when symbols are binned/deleted/restored
  yield* ref
      .read(symbolDaoProvider)
      .searchSymbol(query: query, onlyPinned: onlyPinned, color: color)
      .watch()
      .map((entities) =>
          entities.map(CommunicationSymbol.fromEntity).toList());
}

@riverpod
Stream<List<Board>> searchedBoard(Ref ref) async* {
  final query = ref.watch(localQueryProvider);

  yield* ref.read(boardDaoProvider).searchBoard(query: query).watch().map(
      (entities) => entities.map(Board.fromEntity).toList());
}

@riverpod
class LocalQuery extends _$LocalQuery {
  @override
  String build() => "";

  @override
  set state(String newState) => super.state = newState;
  String update(String Function(String state) cb) => state = cb(state);
}

@riverpod
class Query extends _$Query {
  @override
  String build() => "";

  @override
  set state(String newState) => super.state = newState;
  String update(String Function(String state) cb) => state = cb(state);
}

class SelectedSymbolNotifier extends ChangeNotifier {
  final state = <CommunicationSymbol>[];

  void toggle(CommunicationSymbol symbol) {
    final index = state.indexWhere((e) => e.id == symbol.id);
    if (index == -1) {
      state.add(symbol);
    } else {
      state.removeWhere((element) => element.id == symbol.id);
    }
    notifyListeners();
  }

  void clear() {
    state.clear();
    notifyListeners();
  }
}

final selectedSymbolsProvider =
    ChangeNotifierProvider<SelectedSymbolNotifier>((ref) {
  return SelectedSymbolNotifier();
});

final areMultipleSymbolsSelected = Provider<bool>((ref) {
  final selected = ref.watch(selectedSymbolsProvider);
  return selected.state.length > 1;
});

final areSymbolsSelectedProvider = Provider<bool>((ref) {
  final selected = ref.watch(selectedSymbolsProvider);
  return selected.state.isNotEmpty;
});
