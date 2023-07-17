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
  final List<PersistentDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String settingsEntryKey;
  final Widget? subtitle;
  final Widget? title;

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

    _putValue(newValue);

    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  void _putValue(T? newValue) {
    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValue(widget.settingsEntryKey, newValue);
  }

  Future<T?> _buildDialog(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return SimpleDialog(
            title: widget.title,
            children: widget.items
                .map((e) => RadioListTile(
                      groupValue: _value,
                      title: e.child,
                      value: e.value,
                      onChanged: (value) => Navigator.pop(context, e.value),
                    ))
                .toList());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = widget.items.firstWhere((e) => e.value == _value).child;
    return ListTile(
        title: widget.title,
        subtitle: subtitle,
        onTap: () => _buildDialog(context).then(_onChanged));
  }
}

class PersistentDropdownItem<T> {
  final T value;
  final Widget child;

  const PersistentDropdownItem({required this.value, required this.child});
}
