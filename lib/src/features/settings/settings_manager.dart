import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:isar/isar.dart';

class SettingsManager {
  SettingsManager({
    required this.isar,
  });

  final Isar isar;

  Future<void> putString(String key, String value) async {
    final entry = SettingsEntry(key: key, stringValue: value);
    await isar.writeTxn(() async {
      await isar.settingsEntrys.putByKey(entry);
    });
  }
}
