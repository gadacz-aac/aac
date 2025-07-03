import 'package:flutter/services.dart';

enum OrientationOption {
  portrait,
  landscape,
  auto;

  static OrientationOption fromKey(String key) {
    return OrientationOption.values.firstWhere(
      (e) => e.name == key,
      orElse: () => throw ArgumentError('Invalid SettingKey: $key'),
    );
  }
}

void changeOrientation(String orientation) async {
  final orientationOption = OrientationOption.fromKey(orientation);

  SystemChrome.setPreferredOrientations(switch (orientationOption) {
    OrientationOption.portrait => [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    OrientationOption.landscape => [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    OrientationOption.auto => [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]
  });
}
