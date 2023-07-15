import 'package:aac/src/features/main_menu/ui/main_menu_screen.dart';
import 'package:aac/src/features/settings/change_orientation.dart';
import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await initIsar();
  final orientation = await isar.settingsEntrys.getByKey('orientation');

  changeOrientation(orientation?.value);
  runApp(ProviderScope(
      overrides: [isarPod.overrideWithValue(isar)], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainMenuScreen(), // Set MainMenuScreen as the home screen
    );
  }
}
