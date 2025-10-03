import 'dart:async';
import 'dart:convert';

import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:drift/drift.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_manager.g.dart';

@riverpod
SettingsManager settingsManager(Ref ref) {
  final db = ref.watch(dbProvider);
  final store = ref.watch(settingsCacheProvider);

  return SettingsManager(db, store);
}

@riverpod
SettingsCache settingsCache(Ref ref) {
  throw UnimplementedError();
}

class SettingsCache {
  final Map<SettingKey, dynamic> _store = {};

  var _initilized = Completer();

  final Map<SettingKey, dynamic> _defaults = {
    SettingKey.orientation: OrientationOption.auto.name,
    SettingKey.kiosk: false,
    SettingKey.wakelock: false,
    SettingKey.speechRate: 0.5,
    SettingKey.voice: null,
    SettingKey.speechPitch: 1.0,
  };

  Future<void> initializeStore(AppDatabase db) async {
    if (SettingKey.values.length != _defaults.length) {
      throw Exception("Missing default values for some settings");
    }

    if (_initilized.isCompleted) {
      _initilized = Completer();
    }

    _store.addAll(_defaults);

    final settings = await db.managers.settingTb.get();

    for (var e in settings) {
      try {
        final key = SettingKey.fromKey(e.key);

        _store[key] = jsonDecode(e.value);
      } catch (err) {
        FirebaseCrashlytics.instance.log(err.toString());
      }
    }

    _initilized.complete();
  }

  T get<T>(SettingKey key) {
    return ready ? _store[key] as T : _defaults[key];
  }

  T getDefault<T>(SettingKey key) {
    return _defaults[key] as T;
  }

  void put(SettingKey key, dynamic encoded) {
    _store[key] = encoded;
  }

  bool isKeyValid(SettingKey key) {
    return _defaults.containsKey(key);
  }

  bool get ready {
    return _initilized.isCompleted;
  }

  bool get readyFuture {
    return _initilized.isCompleted;
  }
}

class SettingsManager {
  AppDatabase db;
  SettingsCache store;

  SettingsManager(this.db, this.store);

  Future<T?> getFromDb<T>(String key) {
    return db.managers.settingTb
        .filter((f) => f.key(key))
        .map((e) => jsonDecode(e.value) as T)
        .getSingleOrNull();
  }

  T getValue<T>(SettingKey key) {
    return store.get<T>(key);
  }

  Stream<T> watchValue<T>(SettingKey key) async* {
    yield getValue<T>(key);

    yield* db.managers.settingTb
        .filter((f) => f.key(key.name))
        .map((e) => jsonDecode(e.value) as T)
        .watchSingleOrNull()
        .where((e) => e != null)
        .cast<T>();
  }

  Future<void> putValue(SettingKey key, dynamic value) async {
    if (!store.isKeyValid(key)) {
      throw Exception(
          "The key '$key' is not a valid setting key. Please provide a default value in SettingsManger for the $key");
    }

    final encoded = jsonEncode(value);

    store.put(key, value);
    await db.managers.settingTb.create((f) => f(key: key.name, value: encoded),
        mode: InsertMode.replace);
  }
}
