import 'package:aac/src/features/settings/ui/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:aac/src/features/settings/change_orientation.dart';
import 'package:aac/src/features/settings/ui/switch.dart';

import 'dropdown.dart';

enum OrientationOption { portrait, landscape, auto }

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          PersistentDropdownButton(
            "orientation",
            title: "Orientacja",
            defaultValue: OrientationOption.portrait.name,
            onChanged: changeOrientation,
            items: [
              DropdownMenuItem(
                value: OrientationOption.portrait.name,
                child: const Text('Portrait'),
              ),
              DropdownMenuItem(
                value: OrientationOption.landscape.name,
                child: const Text('Landscape'),
              ),
              DropdownMenuItem(
                value: OrientationOption.auto.name,
                child: const Text('Auto'),
              ),
            ],
          ),
          const PersistentSwitch(
            "kiosk",
            title: "Protective mode",
            subtitle: "Prevent your child from closing the app",
          ),
          const PersistentSlider(
            "speechRate",
            defaultValue: 0.8,
            title: "Speed",
          )
        ],
      ),
    );
  }
}
