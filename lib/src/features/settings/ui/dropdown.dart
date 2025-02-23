import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings_manager.dart';

class PersistentDropdownButton<T> extends ConsumerStatefulWidget {
  const PersistentDropdownButton(
    this.settingsEntryKey, {
    super.key,
    required this.items,
    this.title,
    this.onChanged,
  });

  final List<PersistentDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String settingsEntryKey;
  final Widget? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersistentDropdownState<T>();
}

class _PersistentDropdownState<T>
    extends ConsumerState<PersistentDropdownButton<T>> {
  void _onChanged(T? newValue) {
    _putValue(newValue);

    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  void _putValue(T? newValue) {
    final settingsManager = ref.read(settingsManagerProvider);
    settingsManager.putValue(widget.settingsEntryKey, newValue);
  }

  Future<T?> _buildDialog(BuildContext context, T? value) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return SimpleDialog(
            title: widget.title,
            children: widget.items
                .map((e) => RadioListTile(
                      groupValue: value,
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
    final Stream<T?> stream =
        ref.watch(settingsManagerProvider).watchValue(widget.settingsEntryKey);

    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          final subtitle = snapshot.data == null
              ? Text("Domyślny")
              : widget.items.firstWhere((e) => e.value == snapshot.data).child;

          return ListTile(
              title: widget.title,
              subtitle: subtitle,
              onTap: !snapshot.hasError
                  ? () => _buildDialog(context, snapshot.data).then(_onChanged)
                  : null);
        });
  }
}

class PersistentDropdownItem<T> {
  final T value;
  final Widget child;

  const PersistentDropdownItem({required this.value, required this.child});
}
