import 'package:isar/isar.dart';

import 'board.dart';

part 'communication_symbol.g.dart';

@collection
class CommunicationSymbol {
  CommunicationSymbol({required this.label, required this.imagePath})
      : id = Isar.autoIncrement;

  Id id = Isar.autoIncrement;
  String label;
  String imagePath;

  @Backlink(to: 'symbols')
  final parentBoard = IsarLink<Board>();
  final childBoard = IsarLink<Board>();
}
