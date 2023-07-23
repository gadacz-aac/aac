import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../shared/isar_provider.dart';

final settingsManagerProvider = Provider<SettingsManager>((ref) {
  final isar = ref.watch(isarPod);
  return SettingsManager(isar: isar);
});

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
    await isar.writeTxn(() async {
      final entry = await isar.settingsEntrys.getByKey(key);
      if (entry != null) {
        return await isar.settingsEntrys.put(entry..value = value);
      }
      await isar.settingsEntrys.put(SettingsEntry(key: key, value: value));
    });
  }

  void putValueSync(String key, dynamic value) {
    isar.writeTxnSync(() {
      final entry = isar.settingsEntrys.getByKeySync(key);
      if (entry != null) {
        return isar.settingsEntrys.putSync(entry..value = value);
      }
      isar.settingsEntrys.putSync(SettingsEntry(key: key, value: value));
    });
  }
}
