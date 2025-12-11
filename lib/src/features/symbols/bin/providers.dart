import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../boards/model/board.dart';

part 'providers.g.dart';

@riverpod
Stream<List<CommunicationSymbol>> deletedSymbols(Ref ref) {
  return ref.watch(symbolDaoProvider).watchDeleted();
}

@riverpod
Stream<List<Board>> deletedBoards(Ref ref) {
  return ref.watch(boardDaoProvider).watchDeleted();
}
