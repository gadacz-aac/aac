import 'package:aac/src/features/settings/change_orientation.dart';
import 'package:aac/src/features/settings/providers.dart';
import 'package:flutter/material.dart';
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
              onChanged: (newValue) {
                setState(() {
                  _orientationOption = newValue!;
                });

                final settingsManager = ref.watch(settingsManagerProvider);
                settingsManager.putString(
                    "orientation", _orientationOption.name);

                changeOrientation(_orientationOption.name);
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
