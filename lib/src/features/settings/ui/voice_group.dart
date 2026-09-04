import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/ui/widgets/dropdown.dart';
import 'package:aac/src/features/settings/ui/widgets/group.dart';
import 'package:aac/src/features/settings/ui/widgets/slider.dart';
import 'package:aac/src/features/settings/utils/tts.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceGroup extends StatelessWidget {
  const VoiceGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PersistentGroup(
      title: Text(l10n.speechSettings),
      children: [TtsSpeedRate(), TtsPitch(), VoiceDropdown()],
    );
  }
}

class TtsPitch extends ConsumerWidget {
  const TtsPitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PersistentSlider(
      SettingKey.speechPitch,
      titlePrefix: l10n.voicePitch,
      min: 0.5,
      max: 2.0,
      writeOnChange: false,
      onChanged: ref.read(ttsManagerProvider).setPitch,
    );
  }
}

class TtsSpeedRate extends ConsumerWidget {
  const TtsSpeedRate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PersistentSlider(
      SettingKey.speechRate,
      titlePrefix: l10n.speechRate,
      min: 0.1,
      max: 1.0,
      writeOnChange: false,
      onChanged: ref.read(ttsManagerProvider).setSpeechRate,
    );
  }
}

class VoiceDropdown extends ConsumerWidget {
  const VoiceDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return FutureBuilder(
        future: getVoicesNames(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!;
            return PersistentDropdownButton(SettingKey.voice,
                title: Text(l10n.synthVoice),
                onChanged: ref.read(ttsManagerProvider).setVoice,
                items: data
                    .map(
                        (e) => PersistentDropdownItem(value: e, child: Text(e)))
                    .toList());
          }
          return ListTile(
              title: Text(l10n.voice),
              subtitle: Text(l10n.voiceChangeUnavailable),
              enabled: false);
        });
  }
}