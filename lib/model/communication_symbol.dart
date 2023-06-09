import 'package:isar/isar.dart';

part 'communication_symbol.g.dart';

@collection
class CommunicationSymbol {
  CommunicationSymbol({required this.label, required this.imagePath})
      : id = Isar.autoIncrement;

  Id id = Isar.autoIncrement;
  String label;
  String imagePath;
}
