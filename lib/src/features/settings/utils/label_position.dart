import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Where the label is drawn on a symbol card, relative to the image.
enum LabelPosition {
  under,
  over;

  static LabelPosition fromName(String? name) {
    return LabelPosition.values.firstWhere((e) => e.name == name,
        orElse: () => LabelPosition.under);
  }
}

/// Reactive [LabelPosition] for the UI, persisted via [SettingKey.labelPosition].
final labelPositionProvider = StreamProvider<LabelPosition>((ref) {
  final settingsManager = ref.watch(settingsManagerProvider);

  return settingsManager
      .watchValue<String?>(SettingKey.labelPosition)
      .map(LabelPosition.fromName);
});
