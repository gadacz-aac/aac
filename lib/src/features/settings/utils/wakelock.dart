import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void startWakelock(WidgetRef ref) async {
  final isEnabled =
      await ref.watch(settingsManagerProvider).getValue("wakelock");
  if (isEnabled == null || !isEnabled) return;
  WakelockPlus.enable();
}

void stopWakelock() {
  WakelockPlus.disable();
  return;
}
