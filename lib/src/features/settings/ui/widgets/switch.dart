import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersistentSwitch extends ConsumerStatefulWidget {
  const PersistentSwitch(
    this.settingsEntryKey, {
    super.key,
    this.title,
    this.subtitle,
    this.onChanged,
  });

  final ValueChanged<bool>? onChanged;
  final SettingKey settingsEntryKey;
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
    final settings = ref.watch(settingsManagerProvider);

    final stream = settings.watchValue<bool>(widget.settingsEntryKey);

    return StreamBuilder<bool>(
        stream: stream,
        // there's a split second before the stream is fully loaded where null is provided - default behaviour
        initialData: settings.getValue(widget.settingsEntryKey),
        builder: (context, snapshot) {
          return SwitchListTile(
              title: widget.title,
              subtitle: widget.subtitle,
              value: snapshot.data ?? false,
              onChanged: snapshot.hasError ? null : _onChanged);
        });
  }
}
