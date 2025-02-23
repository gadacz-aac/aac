import 'package:aac/src/features/settings/ui/group.dart';
import 'package:aac/src/features/settings/ui/slider.dart';
import 'package:aac/src/features/settings/ui/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../text_to_speech/tts_manager.dart';
import '../utils/orientation.dart';
import '../utils/tts.dart';
import 'dropdown.dart';

enum SettingKey { orientation, kiosk, wakelock, speechRate, voice }

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
              SettingKey.orientation.name,
              title: const Text("Orientacja"),
              onChanged: changeOrientation,
              items: [
                PersistentDropdownItem(
                  value: OrientationOption.portrait.name,
                  child: const Text('Pionowa'),
                ),
                PersistentDropdownItem(
                  value: OrientationOption.landscape.name,
                  child: const Text('Pozioma'),
                ),
                PersistentDropdownItem(
                  value: OrientationOption.auto.name,
                  child: const Text('Autoobracanie ekranu'),
                ),
              ],
            ),
            PersistentSwitch(
              SettingKey.kiosk.name,
              title: Text("Blokuj wyłączanie aplikacji"),
              subtitle: Text("Nie pozwala na opuszczenie aplikacji w trybie mowy"),
            ),
            PersistentSwitch(
              SettingKey.wakelock.name,
              title: Text("Nie wygaszaj ekranu"),
              subtitle: Text("Wyłącza automatyczne wygaszanie ekranu"),
            ),
            PersistentSlider(
              SettingKey.speechRate.name,
              titlePrefix: "Prędkość mowy",
              min: 0.1,
              max: 1.0,
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
            return PersistentDropdownButton(SettingKey.voice.name,
                title: const Text("Głos syntezatora"), onChanged: (value) {
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
              title: Text('Głos'),
              subtitle: Text('W tej chwili nie możesz zmienić domyślengo głosu'),
              enabled: false);
        });
  }
}
