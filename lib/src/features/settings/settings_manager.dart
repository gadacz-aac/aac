import 'dart:async';
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
  throw UnimplementedError();
}

/// Await [initializeStore] before using this provider
class SettingsManager {
  AppDatabase db;

  final Map<String, dynamic> _store = {};
  final initialized = Completer();

  final Map<String, dynamic> _defaults = {
    SettingKey.orientation.name: OrientationOption.auto.name,
    SettingKey.kiosk.name: false,
    SettingKey.wakelock.name: false,
    SettingKey.speechRate.name: 0.5,
    SettingKey.voice.name: null,
  };

  SettingsManager(this.db);

  Future<void> initializeStore() async {
    _store.addAll(_defaults);

    final settings = await db.managers.settingTb.get();

    for (var e in settings) {
      _store[e.key] = jsonDecode(e.value);
    }

    initialized.complete();
  }

  T getValue<T>(String key) {
    if (!initialized.isCompleted) {
      throw Exception("SettingsManager is not initialized yet.");
    }

    return _store[key] as T;
  }

  Stream<T> watchValue<T>(String key) async* {
    yield getValue<T>(key);

    yield* db.managers.settingTb
        .filter((f) => f.key(key))
        .map((e) => jsonDecode(e.value) as T)
        .watchSingleOrNull()
        .where((e) => e != null)
        .cast<T>();
  }

  Future<void> putValue(String key, dynamic value) async {
    if (!_defaults.containsKey(key)) {
      throw Exception(
          "The key '$key' is not a valid setting key. Please provide a default value in SettingsManger for the $key");
    }

    final encoded = jsonEncode(value);

    _store[key] = encoded;
    await db.managers.settingTb
        .create((f) => f(key: key, value: encoded), mode: InsertMode.replace);
  }
}
