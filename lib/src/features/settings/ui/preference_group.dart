import 'package:aac/src/features/settings/ui/widgets/dropdown.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/ui/widgets/group.dart';
import 'package:aac/src/features/settings/ui/widgets/switch.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:flutter/material.dart';

class PreferenceGroup extends PersistentGroup {
  const PreferenceGroup(
      {super.key,
      super.title = const Text("Preferencje"),
      super.isFirst = true,
      super.children = const [
        OrientationDropdown(),
        PersistentSwitch(
          SettingKey.kiosk,
          title: Text("Blokuj wyłączanie aplikacji"),
          subtitle: Text("Nie pozwala na opuszczenie aplikacji w trybie mowy"),
        ),
        PersistentSwitch(
          SettingKey.wakelock,
          title: Text("Nie wygaszaj ekranu"),
          subtitle: Text("Wyłącza automatyczne wygaszanie ekranu"),
        ),
      ]});
}

class OrientationDropdown extends StatelessWidget {
  const OrientationDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentDropdownButton(
      SettingKey.orientation,
      title: Text("Orientacja"),
      onChanged: changeOrientation,
      items: [
        PersistentDropdownItem(
          value: OrientationOption.portrait.name,
          child: Text('Pionowa'),
        ),
        PersistentDropdownItem(
          value: OrientationOption.landscape.name,
          child: Text('Pozioma'),
        ),
        PersistentDropdownItem(
          value: OrientationOption.auto.name,
          child: Text('Autoobracanie ekranu'),
        ),
      ],
    );
  }
}
