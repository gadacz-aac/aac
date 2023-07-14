import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class PersistentDropdownButton<T> extends ConsumerStatefulWidget {
  const PersistentDropdownButton(
    this.settingsEntryKey, {
    super.key,
    required this.defaultValue,
    required this.items,
    this.title,
    this.subtitle,
    this.onChanged,
  });

  final T defaultValue;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String settingsEntryKey;
  final String? subtitle;
  final String? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersistentDropdownState<T>();
}

class _PersistentDropdownState<T>
    extends ConsumerState<PersistentDropdownButton<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();

    final settingsManager = ref.read(settingsManagerProvider);
    _value = settingsManager.getValueSync(widget.settingsEntryKey) ??
        widget.defaultValue;
  }

  void _onChanged(T? newValue) {
    setState(() {
      if (newValue != null) _value = newValue;
    });

    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValueSync(widget.settingsEntryKey, _value);

    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: widget.title != null ? Text(widget.title!) : null,
        subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
        trailing: DropdownButton(
            value: _value, items: widget.items, onChanged: _onChanged));
  }
}
