import 'package:wakelock/wakelock.dart';
import 'package:aac/src/features/settings/settings_manager.dart';

void startWakelock(ref) async {
  final isEnabled =
      await ref.watch(settingsManagerProvider).getValue("wakelock");
  if (isEnabled == null || !isEnabled) return;
  Wakelock.enable();
}

void stopWakelock() {
  Wakelock.disable();
  return;
}
