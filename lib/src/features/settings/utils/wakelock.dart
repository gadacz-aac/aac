import 'package:wakelock/wakelock.dart';

void startWakelock() {
  Wakelock.enable();
}

void stopWakelock() {
  Wakelock.disable();
}
