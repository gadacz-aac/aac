import 'package:aac/src/features/boards/model/board.dart';
import 'package:isar/isar.dart';

part 'communication_symbol.g.dart';

@collection
class CommunicationSymbol {
  CommunicationSymbol({required this.label, required this.imagePath})
      : id = Isar.autoIncrement;

  Id id;
  String label;
  String imagePath;

  @Backlink(to: 'symbols')
  final parentBoard = IsarLinks<Board>();
  final childBoard = IsarLink<Board>();

  // full text search
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get words => Isar.splitWords(label);
}
