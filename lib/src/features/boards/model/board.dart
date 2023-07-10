import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:isar/isar.dart';

part 'board.g.dart';

@collection
class Board {
  Id id = Isar.autoIncrement;
  int crossAxisCount = 2;
  final symbols = IsarLinks<CommunicationSymbol>();
}
