import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsManagerProvider = Provider<SettingsManager>((ref) {
  final isar = ref.watch(isarPod);
  return SettingsManager(isar: isar);
});
