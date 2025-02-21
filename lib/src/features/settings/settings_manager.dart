import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_manager.g.dart';

@riverpod
SettingsManager settingsManager(Ref ref) {
  // final isar = ref.watch(isarProvider);
  // return SettingsManager(isar: isar);
  // throw UnimplementedError();

  return SettingsManager();
}

class SettingsManager {
  SettingsManager();

  Future<dynamic> getValue(String key) async {
    // final entry = await isar.settingsEntrys.getByKey(key);
    // return entry?.value;

    throw UnimplementedError();
  }

  dynamic getValueSync(String key) {
    // final entry = isar.settingsEntrys.getByKeySync(key);
    // return entry?.value;
    throw UnimplementedError();
  }

  Future<void> putValue(String key, dynamic value) async {
    // await isar.writeTxn(() async {
    //   final entry = await isar.settingsEntrys.getByKey(key);
    //   if (entry != null) {
    //     return await isar.settingsEntrys.put(entry..value = value);
    //   }
    //   await isar.settingsEntrys.put(SettingsEntry(key: key, value: value));
    // });

    throw UnimplementedError();
  }

  void putValueSync(String key, dynamic value) {
    // isar.writeTxnSync(() {
    //   final entry = isar.settingsEntrys.getByKeySync(key);
    //   if (entry != null) {
    //     return isar.settingsEntrys.putSync(entry..value = value);
    //   }
    //   isar.settingsEntrys.putSync(SettingsEntry(key: key, value: value));
    // });
    throw UnimplementedError();
  }
}
