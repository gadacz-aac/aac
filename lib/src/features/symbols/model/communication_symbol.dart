import 'package:aac/src/database/database.dart';

class CommunicationSymbol {
  CommunicationSymbol(
      {required this.id,
      required this.label,
      required this.imagePath,
      this.vocalization,
      this.color,
      this.isDeleted = false});

  String label;
  int id;
  String? vocalization;
  String imagePath;
  int? color;
  bool isDeleted;

  int? childBoardId;

  CommunicationSymbol.fromEntity(CommunicationSymbolEntity entity)
      : imagePath = entity.imagePath,
        label = entity.label,
        color = entity.color,
        isDeleted = entity.isDeleted,
        vocalization = entity.vocalization,
        id = entity.id,
        childBoardId = entity.childBoardId;
}
