import 'package:aac/firebase_options.dart';
import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/utils/app_language.dart';
import 'package:aac/src/features/settings/utils/orientation.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  final db = AppDatabase();
  final settingsStore = SettingsCache();
  await settingsStore.initializeStore(db);

  await db.close();
  final orientation = settingsStore.get<String>(SettingKey.orientation);

  changeOrientation(orientation);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(ProviderScope(
      overrides: [settingsCacheProvider.overrideWithValue(settingsStore)],
      child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider).value;
    return MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AacColors.greyBackground,
            appBarTheme: const AppBarTheme(
                backgroundColor: AacColors.greyBackground,
                elevation: 0,
                scrolledUnderElevation: 0,
                iconTheme: IconThemeData(color: AacColors.iconsGrey),
                systemOverlayStyle: SystemUiOverlayStyle(
                    systemNavigationBarColor: AacColors.greyBackground,
                    systemNavigationBarIconBrightness: Brightness.dark),
                titleTextStyle: TextStyle(
                    color: AacColors.iconsGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: AacColors.greyBackground,
            ),
            brightness: Brightness.light,
            dialogTheme: const DialogThemeData(
                backgroundColor: AacColors.greyBackground)),
        home: BoardScreen(boardId: 1));
  }
}
