import 'package:aac/firebase_options.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/model/settings_entry.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await initIsar();
  final orientation = await isar.settingsEntrys.getByKey('orientation');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

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
      theme: ThemeData(
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
                  fontWeight: FontWeight.bold)),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: AacColors.greyBackground,
          ),
          dialogTheme:
              const DialogTheme(backgroundColor: AacColors.greyBackground)),
      home: BoardScreen(boardId: 1),
      // home: Scaffold(body: Column(children: [ SymbolCard(symbol: CommunicationSymbol(label: "Camus", imagePath: "https://media.newyorker.com/photos/5909675d019dfc3494ea0dd0/master/pass/120409_r22060_g2048.jpg")) ],),),
    );
  }
}
