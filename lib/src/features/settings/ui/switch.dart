import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings_manager.dart';

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
  void _onChanged(bool newValue) {
    ref
        .read(settingsManagerProvider)
        .putValue(widget.settingsEntryKey, newValue);

    if (widget.onChanged != null) widget.onChanged!(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final Stream<bool> stream =
        ref.watch(settingsManagerProvider).watchValue(widget.settingsEntryKey);

    return StreamBuilder<bool>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox();
          }

          final disabled = snapshot.connectionState != ConnectionState.active || snapshot.data == null;
        
          return SwitchListTile(
              title: widget.title,
              subtitle: widget.subtitle,
              value: snapshot.data ?? false,
              onChanged: disabled ? null : _onChanged);
        });
  }
}
