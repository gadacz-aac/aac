import 'package:aac/src/features/settings/change_orientation.dart';
import 'package:aac/src/features/settings/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OrientationOption { portrait, landscape, auto }

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          PersistentDropdownButton("orientation",
              defaultValue: OrientationOption.portrait.name,
              onChanged: changeOrientation,
              items: [
                DropdownMenuItem(
                  value: OrientationOption.portrait.name,
                  child: const Text('Portrait'),
                ),
                DropdownMenuItem(
                  value: OrientationOption.landscape.name,
                  child: const Text('Landscape'),
                ),
                DropdownMenuItem(
                  value: OrientationOption.auto.name,
                  child: const Text('Auto'),
                ),
              ])
        ],
      ),
    );
  }
}

class PersistentDropdownButton<T> extends ConsumerStatefulWidget {
  const PersistentDropdownButton(
    this.settingsEntryKey, {
    super.key,
    required this.defaultValue,
    required this.items,
    this.onChanged,
  });

  final T defaultValue;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String settingsEntryKey;

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
      title: Text(widget.settingsEntryKey),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton(
              value: _value, items: widget.items, onChanged: _onChanged)
        ],
      ),
    );
  }
}
