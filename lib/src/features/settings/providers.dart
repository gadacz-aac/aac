import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsManagerProvider = FutureProvider<SettingsManager>((ref) async {
  final isar = await ref.watch(isarPod.future);
  return SettingsManager(isar: isar);
});

// final orienationProvider = FutureProvider<SettingsManager>((ref) async {
//   final isar = await ref.watch(isarPod.future);

//   final orientationEntry = await isar.settingsEntrys.getByKey('orientation');


// });
