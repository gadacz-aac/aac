import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:isar/isar.dart';

class SettingsManager {
  SettingsManager({
    required this.isar,
  });

  final Isar isar;

  Future<dynamic> getValue(String key) async {
    final entry = await isar.settingsEntrys.getByKey(key);
    return entry?.value;
  }

  dynamic getValueSync(String key) {
    final entry = isar.settingsEntrys.getByKeySync(key);
    return entry?.value;
  }

  Future<void> putValue(String key, dynamic value) async {
    final entry = SettingsEntry(key: key, value: value);
    await isar.writeTxn(() => isar.settingsEntrys.put(entry));
  }

  void putValueSync(String key, dynamic value) {
    final entry = SettingsEntry(key: key, value: value);
    isar.writeTxnSync(() => isar.settingsEntrys.putSync(entry));
  }
}
