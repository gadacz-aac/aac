import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter/services.dart';

void changeOrientation(String orientation) {
  List<DeviceOrientation> preferredOrientations = [];
  if (orientation == OrientationOption.portrait.name) {
    preferredOrientations = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ];
  } else if (orientation == OrientationOption.landscape.name) {
    preferredOrientations = [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];
  } else if (orientation == OrientationOption.auto.name) {
    preferredOrientations = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];
  }
  SystemChrome.setPreferredOrientations(preferredOrientations);
}
