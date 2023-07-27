import 'package:isar/isar.dart';

import 'package:aac/src/features/symbols/model/communication_symbol.dart';

part 'board.g.dart';

@collection
class Board {
  Id id;
  int crossAxisCount;
  Board({
    int? crossAxisCountOrNull,
  })  : id = Isar.autoIncrement,
        crossAxisCount = crossAxisCountOrNull ?? 2;

  final symbols = IsarLinks<CommunicationSymbol>();
}
