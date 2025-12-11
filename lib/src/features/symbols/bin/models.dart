import 'package:aac/src/features/symbols/model/communication_symbol.dart';

class SelectableCommunicationSymbol extends CommunicationSymbol {
  bool isSelected;

  SelectableCommunicationSymbol(
      {required super.id,
      required super.label,
      required super.imagePath,
      required this.isSelected});

  SelectableCommunicationSymbol.fromSymbol(CommunicationSymbol e,
      [bool isSelected = true])
      : this(
            id: e.id,
            label: e.label,
            imagePath: e.imagePath,
            isSelected: isSelected);
}
