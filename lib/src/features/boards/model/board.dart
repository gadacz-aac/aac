import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:isar/isar.dart';

import 'package:aac/src/features/symbols/model/communication_symbol.dart';

part 'board.g.dart';

@collection
class Board {
  Id id;
  int crossAxisCount;
  String name;
  Board({int? crossAxisCountOrNull, required this.name})
      : id = Isar.autoIncrement,
        crossAxisCount = crossAxisCountOrNull ?? 2;

  final symbols = IsarLinks<CommunicationSymbol>();

  factory Board.fromParams(BoardEditingParams params) {
    final board =
        Board(crossAxisCountOrNull: params.columnCount, name: params.name);

    if (params.id == null) return board;

    return board..id = params.id!;
  }

  @override
  String toString() =>
      "board id: $id, crossAxisCount: $crossAxisCount, name: $name";

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get words => Isar.splitWords(name);
}
