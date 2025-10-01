import 'package:aac/src/features/settings/ui/backup_screen.dart';
import 'package:aac/src/features/settings/ui/preference_group.dart';
import 'package:aac/src/features/settings/ui/voice_group.dart';
import 'package:aac/src/features/settings/ui/widgets/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/ui/scaffold.dart';

enum SettingKey {
  orientation,
  kiosk,
  wakelock,
  speechRate,
  voice,
  speechPitch;

  static SettingKey fromKey(String key) {
    return SettingKey.values.firstWhere(
      (e) => e.name == key,
      orElse: () => throw ArgumentError('Invalid SettingKey: $key'),
    );
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen(
      {super.key, required this.children, required this.title});

  final List<PersistentGroup> children;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AacScaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(children: children));
  }
}

class MainSettingsScreen extends ConsumerWidget {
  const MainSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsScreen(
      title: "Ustawienia",
      children: [PreferenceGroup(), VoiceGroup(), BackupGroup()],
    );
  }
}
