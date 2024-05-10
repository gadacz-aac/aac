import 'package:aac/src/features/main_menu/ui/main_menu_screen.dart';
import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await initIsar();
  final orientation = await isar.settingsEntrys.getByKey('orientation');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  changeOrientation(orientation?.value);
  runApp(ProviderScope(
      overrides: [isarPod.overrideWithValue(isar)], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(useMaterial3: true, scaffoldBackgroundColor: Colors.white),
      home: const MainMenuScreen(), // Set MainMenuScreen as the home screen
    );
  }
}
