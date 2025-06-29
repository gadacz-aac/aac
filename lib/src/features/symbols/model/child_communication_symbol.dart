import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';

class ChildCommunicationSymbol extends CommunicationSymbol {
  final int position;
  final bool hidden;
  final int parentBoardId;

  ChildCommunicationSymbol({
    required super.id,
    required super.label,
    required super.imagePath,
    super.vocalization,
    super.color,
    super.isDeleted,
    super.childBoardId,
    required this.position,
    required this.hidden,
    required this.parentBoardId,
  });

  factory ChildCommunicationSymbol.fromEntities({
    required CommunicationSymbolEntity symbolEntity,
    required ChildSymbolEntity childSymbolEntity,
  }) {
    return ChildCommunicationSymbol(
      id: symbolEntity.id,
      label: symbolEntity.label,
      imagePath: symbolEntity.imagePath,
      vocalization: symbolEntity.vocalization,
      color: symbolEntity.color,
      isDeleted: symbolEntity.isDeleted,
      childBoardId: symbolEntity.childBoardId,
      position: childSymbolEntity.position,
      hidden: childSymbolEntity.hidden,
      parentBoardId: childSymbolEntity.boardId,
    );
  }
}
