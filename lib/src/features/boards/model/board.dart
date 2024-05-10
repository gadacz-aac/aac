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

  // full-text search
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get words => Isar.splitWords(name);
}
