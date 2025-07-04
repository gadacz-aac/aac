import 'dart:io';

import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

Future<void> startProtectiveModeIfEnabled(Ref ref) async {
  final isEnabled =
      ref.read(settingsManagerProvider).getValue<bool>(SettingKey.kiosk);

  if (kIsWeb) return;
  if (!Platform.isAndroid) return;
  if (!isEnabled) return;

  await startKioskMode();
}

Future<void> stopProtectiveMode() async {
  if (!kIsWeb && Platform.isAndroid) {
    await stopKioskMode();
  }
}
