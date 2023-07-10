import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum OrientationOption { portrait, landscape, auto }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
              onChanged: (newValue) {
                setState(() {
                  _orientationOption = newValue!;
                });

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

                SystemChrome.setPreferredOrientations(preferredOrientations);

                //widget.onOptionChanged(newValue!);
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
