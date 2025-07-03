import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersistentSlider extends ConsumerStatefulWidget {
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

  final Icon? icon;
  final String titlePrefix;
  final double min;
  final double max;
  final SettingKey settingsEntryKey;
  final ValueChanged<double>? onChanged;
  final bool writeOnChange;

  @override
  ConsumerState<PersistentSlider> createState() => _PersistentSliderState();
}

class _PersistentSliderState extends ConsumerState<PersistentSlider> {
  double value = 0;

  @override
  void initState() {
    super.initState();

    value = ref.read(settingsManagerProvider).getValue(widget.settingsEntryKey);
  }

  void setValue(double newValue) {
    setState(() {
      value = newValue;
    });
  }

  void _onChanged(double newValue, WidgetRef ref) {
    if (widget.writeOnChange) _putValue(newValue, ref);

    if (widget.onChanged != null) widget.onChanged!(newValue);

    setValue(newValue);
  }

  void _putValue(double newValue, WidgetRef ref) {
    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValue(widget.settingsEntryKey, newValue);

    setValue(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: widget.icon,
      title: Text("${widget.titlePrefix}: ${value.toStringAsFixed(2)}"),
      subtitle: Slider(
        min: widget.min,
        max: widget.max,
        value: value,
        onChanged: (val) => _onChanged(val, ref),
        onChangeEnd: widget.writeOnChange ? null : (val) => _putValue(val, ref),
      ),
    );
  }
}
