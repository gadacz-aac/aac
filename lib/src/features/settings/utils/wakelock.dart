import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void startWakelock(WidgetRef ref) async {
  final isEnabled =
      ref.watch(settingsManagerProvider).getValue(SettingKey.wakelock);
  if (isEnabled == null || !isEnabled) return;
  WakelockPlus.enable();
}

void stopWakelock() {
  WakelockPlus.disable();
  return;
}
