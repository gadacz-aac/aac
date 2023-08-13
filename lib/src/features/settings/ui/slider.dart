import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings_manager.dart';

class PersistentSlider extends ConsumerStatefulWidget {
  final Icon? icon;

  final String titlePrefix;

  final double min;
  final double max;

  final double defaultValue;

  final String settingsEntryKey;

  final ValueChanged<double>? onChanged;

  final bool writeOnChange;

  const PersistentSlider(
    this.settingsEntryKey, {
    Key? key,
    this.icon,
    required this.titlePrefix,
    this.min = 0.0,
    this.max = 1.0,
    this.onChanged,
    this.writeOnChange = false,
    required this.defaultValue,
  }) : super(key: key);

  @override
  ConsumerState<PersistentSlider> createState() => _PersistentSliderState();
}

class _PersistentSliderState extends ConsumerState<PersistentSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();

    final settingsManager = ref.read(settingsManagerProvider);
    _value = settingsManager.getValueSync(widget.settingsEntryKey) ??
        widget.defaultValue;
  }

  void _onChanged(double newValue) {
    setState(() {
      _value = newValue;
    });

    if (widget.writeOnChange) _putValue(newValue);

    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  void _putValue(double newValue) {
    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValue(widget.settingsEntryKey, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      leading: widget.icon,
      title: Text("${widget.titlePrefix}: ${_value.toStringAsFixed(2)}"),
      subtitle: Slider(
        min: widget.min,
        max: widget.max,
        value: _value,
        onChanged: _onChanged,
        onChangeEnd: widget.writeOnChange ? null : _putValue,
      ),
    );
  }
}
