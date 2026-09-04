import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const defaultLanguage = 'pl';

/// Reactive app locale, persisted via [SettingKey.language].
final appLocaleProvider = StreamProvider<Locale>((ref) {
  final settingsManager = ref.watch(settingsManagerProvider);

  return settingsManager
      .watchValue<String?>(SettingKey.language)
      .map((name) => Locale(name ?? defaultLanguage));
});

/// Language code used by services (e.g. the Arasaac search), following the
/// app language.
final appLanguageCodeProvider = Provider<String>((ref) {
  final locale = ref.watch(appLocaleProvider).value;
  return locale?.languageCode ?? defaultLanguage;
});
