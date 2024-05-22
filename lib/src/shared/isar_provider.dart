import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

Future<Isar> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
      [CommunicationSymbolSchema, BoardSchema, SettingsEntrySchema],
      directory: dir.path);

  isar.writeTxn(() async {
    final board = await isar.boards.get(1);
    if (board == null) {
      await isar.boards.put(Board(name: "Główna"));
    }
  });

  return isar;
}

// we're going to override this provider in main(). alternativly we could use
// FutureProvider but this will give us some additional benifits
// - https://github.com/piotrek813/aac/issues/26
// - https://docs-v2.riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@riverpod
Isar isar(IsarRef ref) {
  throw UnimplementedError();
}
