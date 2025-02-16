import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';

class BoardOld {
  int id;
  int crossAxisCount;
  String name;
  // final symbols = IsarLinks<CommunicationSymbol>();
  final symbols = [];
  List<int> reorderedSymbols = List.empty(growable: true);

  BoardOld(
      {int? crossAxisCountOrNull,
      required this.name})
      : crossAxisCount = crossAxisCountOrNull ?? 3,
        id = 1;

  factory BoardOld.fromParams(BoardEditingParams params) {
    final board =
        BoardOld(crossAxisCountOrNull: params.columnCount, name: params.name);

    board.reorderedSymbols = params.reorderedSymbols;

    if (params.id == null) return board;

    return board..id = params.id!;
  }

  BoardOld.fromEntity(BoardEntity entity) : 
    id = entity.id,
    crossAxisCount = entity.crossAxisCount,
    name = entity.name;

  @override
  String toString() =>
      "board id: $id, crossAxisCount: $crossAxisCount, name: $name, symbols: $symbols, reorderedSymbols: $reorderedSymbols";

  // @Index(type: IndexType.value, caseSensitive: false)
  List<String> get words => [];
}

