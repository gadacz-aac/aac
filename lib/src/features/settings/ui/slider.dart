import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings_manager.dart';

class PersistentSlider extends ConsumerWidget {
  final Icon? icon;
  final String titlePrefix;
  final double min;
  final double max;
  final String settingsEntryKey;
  final ValueChanged<double>? onChanged;
  final bool writeOnChange;

  const PersistentSlider(
    this.settingsEntryKey, {
    super.key,
    this.icon,
    required this.titlePrefix,
    this.min = 0.0,
    this.max = 1.0,
    this.onChanged,
    this.writeOnChange = false,
  });

  void _onChanged(double newValue, WidgetRef ref, setValue) {
    if (writeOnChange) _putValue(newValue, ref, setValue);

    if (onChanged != null) onChanged!(newValue);

    setValue(newValue);
  }

  void _putValue(double newValue, WidgetRef ref, setValue) {
    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValue(settingsEntryKey, newValue);

    setValue(newValue);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future =
        ref.watch(settingsManagerProvider).getValue(settingsEntryKey);

    return StatefulBuilder(builder: (context, setState) {
      double value = future;

      void setValue(double newValue) {
        setState(() {
          value = newValue;
        });
      }

      return ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        leading: icon,
        title: Text("$titlePrefix: ${value.toStringAsFixed(2)}"),
        subtitle: Slider(
          min: min,
          max: max,
          value: value,
          onChanged: (val) => _onChanged(val, ref, setValue),
          onChangeEnd:
              writeOnChange ? null : (val) => _putValue(val, ref, setValue),
        ),
      );
    });
  }
}
