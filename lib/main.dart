import 'package:aac/src/features/main_menu/ui/main_menu_screen.dart';
import 'package:aac/src/features/symbols/create_symbol_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
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

Future<List<String>?> openMenu(BuildContext context) async {
  final result = await Navigator.push(
      context,
      MaterialPageRoute<List<String>>(
          builder: (context) => const AddSymbolMenu()));
  return result;
}
