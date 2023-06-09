import 'package:isar/isar.dart';

import 'package:aac/model/communication_symbol.dart';

class SymbolManager {
  SymbolManager({
    required this.isar,
  });

  final Isar isar;

  Future<void> saveSymbol(String label, String imagePath) async {
    await isar.writeTxn(() async {
      final CommunicationSymbol symbol =
          CommunicationSymbol(label: label, imagePath: imagePath);
      await isar.communicationSymbols.put(symbol);
    });
  }

  Stream<List<CommunicationSymbol>> watchSymbols() async* {
    yield* isar.communicationSymbols.where().watch(fireImmediately: true);
  }
}
