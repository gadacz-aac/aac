import 'package:aac/src/features/settings/ui/group.dart';
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
      body: ListView(
        children: [
          PersistentGroup(isFirst: true, children: [
            PersistentDropdownButton(
              "orientation",
              title: const Text("Orientacja"),
              subtitle: const Text("change orientation for board screen"),
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
              title: Text("Protective mode"),
              subtitle: Text("Prevent your child from closing the app"),
            ),
          ]),
          const PersistentGroup(children: [
            PersistentSlider(
              "speechRate",
              defaultValue: 0.8,
              title: Text("Speed"),
            ),
          ]),
          const PersistentGroup(title: Text("Połączenia"), children: [
            PersistentSwitch(
              "notifications",
              title: Text("Powiadomienia"),
            ),
            PersistentDropdownButton("sound",
                defaultValue: "Friends of misery",
                title: Text("Dzwonek"),
                items: [
                  DropdownMenuItem(
                      value: "Friends of misery",
                      child: Text("Friends of misery"))
                ]),
            PersistentSwitch(
              "vibration",
              title: Text("Wibracje"),
            ),
          ])
        ],
      ),
    );
  }
}
