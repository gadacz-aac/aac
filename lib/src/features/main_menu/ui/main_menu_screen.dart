import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/utils/protective_mode.dart';
import 'package:aac/src/features/settings/utils/wakelock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                ref.read(isParentModeProvider.notifier).update((state) => true);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardScreen(boardId: 1),
                  ),
                );
              },
              child: const Text('AAC Board - parent mode'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(isParentModeProvider.notifier)
                    .update((state) => false);
                startWakelock(ref);
                startProtectiveModeIfEnabled(ref);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BoardScreen(boardId: 1),
                  ),
                ).then((_) => stopWakelock());
              },
              child: const Text('AAC Board - child mode'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopScreen(),
                  ),
                );
              },
              child: const Text('Shop'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(
        child: Text('Login'),
      ),
    );
  }
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: const Center(
        child: Text('Shop'),
      ),
    );
  }
}
