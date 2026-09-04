import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/ui/widgets/dropdown.dart';
import 'package:aac/src/features/settings/ui/widgets/group.dart';
import 'package:aac/src/features/settings/ui/widgets/switch.dart';
import 'package:aac/src/features/settings/utils/app_language.dart';
import 'package:aac/src/features/settings/utils/label_position.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:flutter/material.dart';

class PreferenceGroup extends StatelessWidget {
  const PreferenceGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PersistentGroup(
      isFirst: true,
      title: Text(l10n.preferences),
      children: [
        OrientationDropdown(),
        LabelPositionDropdown(),
        LanguageDropdown(),
        PersistentSwitch(
          SettingKey.kiosk,
          title: Text(l10n.blockAppExit),
          subtitle: Text(l10n.blockAppExitSubtitle),
        ),
        PersistentSwitch(
          SettingKey.wakelock,
          title: Text(l10n.keepScreenOn),
          subtitle: Text(l10n.keepScreenOnSubtitle),
        ),
      ],
    );
  }
}

class OrientationDropdown extends StatelessWidget {
  const OrientationDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PersistentDropdownButton(
      SettingKey.orientation,
      title: Text(l10n.orientation),
      onChanged: changeOrientation,
      items: [
        PersistentDropdownItem(
          value: OrientationOption.portrait.name,
          child: Text(l10n.portrait),
        ),
        PersistentDropdownItem(
          value: OrientationOption.landscape.name,
          child: Text(l10n.landscape),
        ),
        PersistentDropdownItem(
          value: OrientationOption.auto.name,
          child: Text(l10n.autoRotate),
        ),
      ],
    );
  }
}

class LabelPositionDropdown extends StatelessWidget {
  const LabelPositionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PersistentDropdownButton(
      SettingKey.labelPosition,
      title: Text(l10n.labelPosition),
      items: [
        PersistentDropdownItem(
          value: LabelPosition.under.name,
          child: Text(l10n.labelPositionUnder),
        ),
        PersistentDropdownItem(
          value: LabelPosition.over.name,
          child: Text(l10n.labelPositionOver),
        ),
      ],
    );
  }
}

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PersistentDropdownButton(
      SettingKey.language,
      title: Text(l10n.language),
      items: [
        PersistentDropdownItem(
          value: defaultLanguage,
          child: Text(l10n.languagePolish),
        ),
        PersistentDropdownItem(
          value: 'en',
          child: Text(l10n.languageEnglish),
        ),
      ],
    );
  }
}