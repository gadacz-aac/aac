import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class PersistentSwitch extends ConsumerStatefulWidget {
  const PersistentSwitch(
    this.settingsEntryKey, {
    super.key,
    this.defaultValue = false,
    this.title,
    this.subtitle,
    this.onChanged,
  });

  final bool? defaultValue;
  final ValueChanged<bool>? onChanged;
  final String settingsEntryKey;
  final Widget? subtitle;
  final Widget? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersistentSwitch();
}

class _PersistentSwitch<T> extends ConsumerState<PersistentSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();

    final settingsManager = ref.read(settingsManagerProvider);
    _value = settingsManager.getValueSync(widget.settingsEntryKey) ??
        widget.defaultValue;
  }

  void _onChanged(bool newValue) {
    setState(() {
      _value = newValue;
    });

    _putValue(newValue);

    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  void _putValue(bool newValue) {
    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValue(widget.settingsEntryKey, newValue);
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: widget.title,
      subtitle: widget.subtitle,
      value: _value,
      onChanged: (newValue) {
        setState(() {
          _value = newValue;
        });
        _onChanged(newValue);
      },
    );
  }
}
