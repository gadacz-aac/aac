import 'package:isar/isar.dart';

import 'communication_symbol.dart';

part 'board.g.dart';

@collection
class Board {
  Id id = Isar.autoIncrement;
  final symbols = IsarLinks<CommunicationSymbol>();
}
