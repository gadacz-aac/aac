import 'package:aac/src/features/settings/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OrientationOption { portrait, landscape, auto }

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  OrientationOption _orientationOption = OrientationOption.portrait;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Orientation:',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButton<OrientationOption>(
              value: _orientationOption,
              onChanged: (newValue) async {
                setState(() {
                  _orientationOption = newValue!;
                });

                final settingsManager =
                    await ref.watch(settingsManagerProvider.future);
                settingsManager.putString(
                    "orientation", _orientationOption.name);

                List<DeviceOrientation> preferredOrientations = [];
                if (_orientationOption == OrientationOption.portrait) {
                  preferredOrientations = [
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ];
                } else if (_orientationOption == OrientationOption.landscape) {
                  preferredOrientations = [
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ];
                } else if (_orientationOption == OrientationOption.auto) {
                  preferredOrientations = [
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ];
                }

                print(preferredOrientations);
                SystemChrome.setPreferredOrientations(preferredOrientations);
              },
              items: const [
                DropdownMenuItem(
                  value: OrientationOption.portrait,
                  child: Text('Portrait'),
                ),
                DropdownMenuItem(
                  value: OrientationOption.landscape,
                  child: Text('Landscape'),
                ),
                DropdownMenuItem(
                  value: OrientationOption.auto,
                  child: Text('Auto'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
