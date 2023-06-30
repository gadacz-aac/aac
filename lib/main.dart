import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/symbols/create_symbol_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: BoardScreen(
      boardId: 1,
    ));
  }
}

Future<List<String>?> openMenu(BuildContext context) async {
  final result = await Navigator.push(
      context,
      MaterialPageRoute<List<String>>(
          builder: (context) => const AddSymbolMenu()));
  return result;
}
