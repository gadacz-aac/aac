import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      overrides: [isarProvider.overrideWithValue(isar)],
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(we declare a provider with autoDispose, its state will be disposed as soon as the last listener is removed (typically
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: AacColors.sentenceBarGrey,
              elevation: 0,
              scrolledUnderElevation: 0,
              iconTheme: IconThemeData(color: AacColors.iconsGrey),
              titleTextStyle: TextStyle(
                  color: AacColors.iconsGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
      home: BoardScreen(boardId: 1),
    );
  }
}
