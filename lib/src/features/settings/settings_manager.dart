import 'dart:convert';

import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_manager.g.dart';

@riverpod
SettingsManager settingsManager(Ref ref) {
  final db = ref.watch(dbProvider);

  return SettingsManager(db);
}

class SettingsManager {
  AppDatabase db;

  SettingsManager(this.db);

  Selectable<T> _get<T>(String key) {
    return db.managers.setting
        .filter((f) => f.key(key))
        .map((e) => jsonDecode(e.value) as T);
  }

  Future<T> getValue<T>(String key) async {
    return _get<T>(key).getSingle();
  }

  Stream<T> watchValue<T>(String key) {
    return _get<T>(key).watchSingle();
  }

  Future<void> putValue(String key, dynamic value) async {
    await db.managers.setting.create(
        (f) => f(key: key, value: jsonEncode(value)),
        mode: InsertMode.replace);
  }

  Future<void> insertDefaultSettings() async {
    await db.transaction(() async {
      // accessability
      await putValue(SettingKey.orientation.name, OrientationOption.auto.name);
      await putValue(SettingKey.kiosk.name, false);
      await putValue(SettingKey.wakelock.name, false);

      // tts settings
      await putValue(SettingKey.speechRate.name, 0.5);
      await putValue(SettingKey.voice.name, null);
    });
  }
}
