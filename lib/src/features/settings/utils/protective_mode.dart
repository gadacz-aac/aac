import 'dart:io';

import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

Future<void> startProtectiveModeIfEnabled(ref) async {
  final isEnabled = await ref.watch(settingsManagerProvider).getValue("kiosk");

  if (kIsWeb) return;
  if (!Platform.isAndroid) return;
  if (isEnabled == null || !isEnabled) return;

  await startKioskMode();
}

Future<void> stopProtectiveMode() async {
  if (!kIsWeb && Platform.isAndroid) {
    await stopKioskMode();
  }
}
