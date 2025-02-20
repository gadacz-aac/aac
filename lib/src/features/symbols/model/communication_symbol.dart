import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';

class CommunicationSymbolOld {
  CommunicationSymbolOld(
      {required this.label,
      required this.imagePath,
      this.vocalization,
      this.color,
      this.isDeleted = false})
      : id = 1;

  int id;
  String label;
  String? vocalization;
  String imagePath;
  int? color;
  bool isDeleted;

  final parentBoard = BoardOld(name: "");
  final childBoard = BoardOld(name: "");

  // full-text search
  List<String> get words => [];

  CommunicationSymbolOld.fromParams(SymbolEditingParams params)
        : this(
                  imagePath: params.imagePath ?? "",
                  label: params.label ?? "",
                  color: params.color,
                  vocalization: params.vocalization,
                  isDeleted: params.isDeleted ?? false
                );

  CommunicationSymbolOld.fromEntity(CommunicationSymbolEntity entity) 
  : imagePath = entity.imagePath,
          label = entity.label,
          color = entity.color,
          isDeleted =  entity.isDeleted,
          vocalization = entity.vocalization,
          id = entity.id;

  CommunicationSymbolOld updateWithParams(SymbolEditingParams params) {
    label = params.label ?? label;
    imagePath = params.imagePath ?? imagePath;
    color = params.color ?? color;
    vocalization = params.vocalization ?? vocalization;
    isDeleted = params.isDeleted ?? isDeleted;
    return this;
  }

}

