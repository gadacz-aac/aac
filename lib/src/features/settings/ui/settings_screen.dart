import 'package:aac/src/features/settings/ui/group.dart';
import 'package:aac/src/features/settings/ui/slider.dart';
import 'package:aac/src/features/settings/ui/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../text_to_speech/tts_manager.dart';
import '../utils/orientation.dart';
import '../utils/tts.dart';
import 'dropdown.dart';

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
                PersistentDropdownItem(
                  value: OrientationOption.portrait.name,
                  child: const Text('Portrait'),
                ),
                PersistentDropdownItem(
                  value: OrientationOption.landscape.name,
                  child: const Text('Landscape'),
                ),
                PersistentDropdownItem(
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
            const PersistentSwitch(
              "wakelock",
              title: Text("Do you want to have your eyes burned?"),
              subtitle: Text("Prevent your battery from lasting too long"),
            ),
            PersistentSlider(
              "speechRate",
              titlePrefix: "Prędkość mowy",
              min: 0.1,
              max: 2.0,
              defaultValue: 1.0,
              writeOnChange: false,
              onChanged: (value) {
                ref.read(ttsManagerProvider).setSpeechRate(value);
              },
            ),
          ]),
          const VoiceDropdown(),
        ],
      ),
    );
  }
}

class VoiceDropdown extends ConsumerWidget {
  const VoiceDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: getVoicesNames(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!;
            return PersistentDropdownButton('voice',
                title: const Text("Voice"),
                defaultValue: data.first, onChanged: (value) {
              if (value != null) {
                ref.read(ttsManagerProvider).setVoice(value);
              }
            },
                items: data
                    .map(
                        (e) => PersistentDropdownItem(value: e, child: Text(e)))
                    .toList());
          }
          return const ListTile(
              title: Text('Voice'),
              subtitle: Text('not available'),
              enabled: false);
        });
  }
}
