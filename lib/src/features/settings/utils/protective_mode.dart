import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

Future<void> startProtectiveMode() async {
  if (!kIsWeb && Platform.isAndroid) {
    await startKioskMode();
  }
}

Future<void> stopProtectiveMode() async {
  if (!kIsWeb && Platform.isAndroid) {
    await stopKioskMode();
  }
}
