import 'dart:async';

import 'package:flutter/services.dart';

enum OrientationOption { portrait, landscape, auto }

void changeOrientation(FutureOr<String>? orientation) async {
  orientation = await orientation;

  if (orientation == null) return;
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
