import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:isar/isar.dart';

part 'communication_symbol.g.dart';

@collection
class CommunicationSymbol {
  CommunicationSymbol(
      {required this.label,
      required this.imagePath,
      this.vocalization,
      this.color,
      this.isDeleted = false})
      : id = Isar.autoIncrement;

  Id id;
  String label;
  String? vocalization;
  String imagePath;
  int? color;
  bool isDeleted;

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
                  color: params.color,
                  vocalization: params.vocalization,
                  isDeleted: params.isDeleted ?? false
                );

  CommunicationSymbol updateWithParams(SymbolEditingParams params) {
    label = params.label ?? label;
    imagePath = params.imagePath ?? imagePath;
    color = params.color ?? color;
    vocalization = params.vocalization ?? vocalization;
    isDeleted = params.isDeleted ?? isDeleted;
    return this;
  }
}

// extension CommunicationSymbolCollectionExtension on IsarCollection<CommunicationSymbol> {
//   Stream<List<CommunicationSymbol>> watchSymbols() {
//     return watchLazy().asyncMap((_) async {
//       final results = getAllSync([]);
//       return results.whereType<CommunicationSymbol>().toList();
//     });
//   }
// }