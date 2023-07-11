import 'package:aac/src/features/main_menu/ui/main_menu_screen.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await initIsar();
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
