import 'package:aac/src/database/database.dart';

class Board {
  int id;
  int crossAxisCount;
  String name;

  Board({required this.id, int? crossAxisCountOrNull, required this.name})
      : crossAxisCount = crossAxisCountOrNull ?? 3;

  Board.fromEntity(BoardEntity entity)
      : id = entity.id,
        crossAxisCount = entity.crossAxisCount,
        name = entity.name;

  @override
  String toString() =>
      "board id: $id, crossAxisCount: $crossAxisCount, name: $name";
}
