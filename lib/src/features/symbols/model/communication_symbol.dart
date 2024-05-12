import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:isar/isar.dart';

part 'communication_symbol.g.dart';

@collection
class CommunicationSymbol {
  CommunicationSymbol(
      {required this.label, required this.imagePath, this.color})
      : id = Isar.autoIncrement;

  Id id;
  String label;
  String imagePath;
  int? color;

  @Backlink(to: 'symbols')
  final parentBoard = IsarLinks<Board>();
  final childBoard = IsarLink<Board>();

  // full-text search
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get words => Isar.splitWords(label);

  CommunicationSymbol.fromParams(SymbolEditingParams params)
      : this(
            imagePath: params.imagePath ?? "",
            label: params.label ?? "",
            color: params.color);

  CommunicationSymbol updateWithParams(SymbolEditingParams params) {
    label = params.label ?? label;
    imagePath = params.imagePath ?? imagePath;
    color = params.color;
    return this;
  }
}
