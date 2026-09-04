import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @cancel.
  ///
  /// In pl, this message translates to:
  /// **'Anuluj'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz'**
  String get save;

  /// No description provided for @yes.
  ///
  /// In pl, this message translates to:
  /// **'Tak'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In pl, this message translates to:
  /// **'Nie'**
  String get no;

  /// No description provided for @delete.
  ///
  /// In pl, this message translates to:
  /// **'Usuń'**
  String get delete;

  /// No description provided for @deleteForever.
  ///
  /// In pl, this message translates to:
  /// **'Usuń na zawsze'**
  String get deleteForever;

  /// No description provided for @restore.
  ///
  /// In pl, this message translates to:
  /// **'Przywróć'**
  String get restore;

  /// No description provided for @settings.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settings;

  /// No description provided for @open.
  ///
  /// In pl, this message translates to:
  /// **'Otwórz'**
  String get open;

  /// No description provided for @edit.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj'**
  String get edit;

  /// No description provided for @defaultLabel.
  ///
  /// In pl, this message translates to:
  /// **'Domyślny'**
  String get defaultLabel;

  /// No description provided for @search.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj'**
  String get search;

  /// No description provided for @unpin.
  ///
  /// In pl, this message translates to:
  /// **'Odepnij'**
  String get unpin;

  /// No description provided for @pin.
  ///
  /// In pl, this message translates to:
  /// **'Przypnij'**
  String get pin;

  /// No description provided for @confirm.
  ///
  /// In pl, this message translates to:
  /// **'Zatwierdź'**
  String get confirm;

  /// No description provided for @errorPrefix.
  ///
  /// In pl, this message translates to:
  /// **'Błąd: {error}'**
  String errorPrefix(String error);

  /// No description provided for @oops.
  ///
  /// In pl, this message translates to:
  /// **'Oops..'**
  String get oops;

  /// No description provided for @boardNotFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono tablicy o id {id}'**
  String boardNotFound(int id);

  /// No description provided for @lockHint.
  ///
  /// In pl, this message translates to:
  /// **'Stuknij jeszcze {count} razy, aby wyjść z trybu ochrony'**
  String lockHint(int count);

  /// No description provided for @symbolsTab.
  ///
  /// In pl, this message translates to:
  /// **'Symbole'**
  String get symbolsTab;

  /// No description provided for @boardsTab.
  ///
  /// In pl, this message translates to:
  /// **'Tablice'**
  String get boardsTab;

  /// No description provided for @noMatching.
  ///
  /// In pl, this message translates to:
  /// **'Brak pasujących {what}'**
  String noMatching(String what);

  /// No description provided for @someDeleted.
  ///
  /// In pl, this message translates to:
  /// **'Część {what} mogła zostać usunięta'**
  String someDeleted(String what);

  /// No description provided for @symbolsGenitive.
  ///
  /// In pl, this message translates to:
  /// **'symboli'**
  String get symbolsGenitive;

  /// No description provided for @boardsGenitive.
  ///
  /// In pl, this message translates to:
  /// **'tablic'**
  String get boardsGenitive;

  /// No description provided for @searchBoards.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj w tablicach'**
  String get searchBoards;

  /// No description provided for @unpinnedChip.
  ///
  /// In pl, this message translates to:
  /// **'Nieprzypięte'**
  String get unpinnedChip;

  /// No description provided for @colorChip.
  ///
  /// In pl, this message translates to:
  /// **'Kolor'**
  String get colorChip;

  /// No description provided for @bin.
  ///
  /// In pl, this message translates to:
  /// **'Kosz'**
  String get bin;

  /// No description provided for @addSomeSymbols.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj jakieś symbole'**
  String get addSomeSymbols;

  /// No description provided for @editBoard.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj tablicę'**
  String get editBoard;

  /// No description provided for @lock.
  ///
  /// In pl, this message translates to:
  /// **'Zablokuj'**
  String get lock;

  /// No description provided for @deleteBoardsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Usuń tablice i symbole'**
  String get deleteBoardsTitle;

  /// No description provided for @chooseSymbolsToBin.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz symbole, które chcesz \nprzenieść do kosza'**
  String get chooseSymbolsToBin;

  /// No description provided for @rememberRestorable.
  ///
  /// In pl, this message translates to:
  /// **'Pamiętaj, że możesz je zawsze przywrócić'**
  String get rememberRestorable;

  /// No description provided for @restoreBoardTitle.
  ///
  /// In pl, this message translates to:
  /// **'Przywróć tablicę i symbole'**
  String get restoreBoardTitle;

  /// No description provided for @chooseSymbolsToRestore.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz symbole, które chcesz \nprzywrócić'**
  String get chooseSymbolsToRestore;

  /// No description provided for @deleteBoardTitle.
  ///
  /// In pl, this message translates to:
  /// **'Usuń tablicę i symbole'**
  String get deleteBoardTitle;

  /// No description provided for @chooseSymbolsToDelete.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz symbole, które chcesz \nusunąć'**
  String get chooseSymbolsToDelete;

  /// No description provided for @viewPreview.
  ///
  /// In pl, this message translates to:
  /// **'Zobacz podgląd'**
  String get viewPreview;

  /// No description provided for @noDeletedBoards.
  ///
  /// In pl, this message translates to:
  /// **'Brak usuniętych tablic'**
  String get noDeletedBoards;

  /// No description provided for @noDeletedSymbols.
  ///
  /// In pl, this message translates to:
  /// **'Brak usuniętych symboli'**
  String get noDeletedSymbols;

  /// No description provided for @binEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Kosz jest pusty'**
  String get binEmpty;

  /// No description provided for @preferences.
  ///
  /// In pl, this message translates to:
  /// **'Preferencje'**
  String get preferences;

  /// No description provided for @blockAppExit.
  ///
  /// In pl, this message translates to:
  /// **'Blokuj wyłączanie aplikacji'**
  String get blockAppExit;

  /// No description provided for @blockAppExitSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Nie pozwala na opuszczenie aplikacji w trybie mowy'**
  String get blockAppExitSubtitle;

  /// No description provided for @keepScreenOn.
  ///
  /// In pl, this message translates to:
  /// **'Nie wygaszaj ekranu'**
  String get keepScreenOn;

  /// No description provided for @keepScreenOnSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Wyłącza automatyczne wygaszanie ekranu'**
  String get keepScreenOnSubtitle;

  /// No description provided for @orientation.
  ///
  /// In pl, this message translates to:
  /// **'Orientacja'**
  String get orientation;

  /// No description provided for @portrait.
  ///
  /// In pl, this message translates to:
  /// **'Pionowa'**
  String get portrait;

  /// No description provided for @landscape.
  ///
  /// In pl, this message translates to:
  /// **'Pozioma'**
  String get landscape;

  /// No description provided for @autoRotate.
  ///
  /// In pl, this message translates to:
  /// **'Autoobracanie ekranu'**
  String get autoRotate;

  /// No description provided for @labelPosition.
  ///
  /// In pl, this message translates to:
  /// **'Pozycja podpisu'**
  String get labelPosition;

  /// No description provided for @labelPositionUnder.
  ///
  /// In pl, this message translates to:
  /// **'Pod obrazkiem'**
  String get labelPositionUnder;

  /// No description provided for @labelPositionOver.
  ///
  /// In pl, this message translates to:
  /// **'Nad obrazkiem'**
  String get labelPositionOver;

  /// No description provided for @language.
  ///
  /// In pl, this message translates to:
  /// **'Język'**
  String get language;

  /// No description provided for @languagePolish.
  ///
  /// In pl, this message translates to:
  /// **'Polski'**
  String get languagePolish;

  /// No description provided for @languageEnglish.
  ///
  /// In pl, this message translates to:
  /// **'Angielski'**
  String get languageEnglish;

  /// No description provided for @speechSettings.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia mowy'**
  String get speechSettings;

  /// No description provided for @voicePitch.
  ///
  /// In pl, this message translates to:
  /// **'Wysokość głosu'**
  String get voicePitch;

  /// No description provided for @speechRate.
  ///
  /// In pl, this message translates to:
  /// **'Prędkość mowy'**
  String get speechRate;

  /// No description provided for @synthVoice.
  ///
  /// In pl, this message translates to:
  /// **'Głos syntezatora'**
  String get synthVoice;

  /// No description provided for @voice.
  ///
  /// In pl, this message translates to:
  /// **'Głos'**
  String get voice;

  /// No description provided for @voiceChangeUnavailable.
  ///
  /// In pl, this message translates to:
  /// **'W tej chwili nie możesz zmienić domyślnego głosu'**
  String get voiceChangeUnavailable;

  /// No description provided for @exportImport.
  ///
  /// In pl, this message translates to:
  /// **'Eksport i import'**
  String get exportImport;

  /// No description provided for @backup.
  ///
  /// In pl, this message translates to:
  /// **'Kopia zapasowa'**
  String get backup;

  /// No description provided for @backupSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Eksportuj lub importuj ustawienia aplikacji'**
  String get backupSubtitle;

  /// No description provided for @export.
  ///
  /// In pl, this message translates to:
  /// **'Eksportuj'**
  String get export;

  /// No description provided for @import.
  ///
  /// In pl, this message translates to:
  /// **'Importuj'**
  String get import;

  /// No description provided for @label.
  ///
  /// In pl, this message translates to:
  /// **'Podpis'**
  String get label;

  /// No description provided for @vocalization.
  ///
  /// In pl, this message translates to:
  /// **'Wokalizacja (opcjonalnie)'**
  String get vocalization;

  /// No description provided for @vocalizationHelper.
  ///
  /// In pl, this message translates to:
  /// **'Co powiedzieć po naciśnięciu?'**
  String get vocalizationHelper;

  /// No description provided for @duplicateSymbolExists.
  ///
  /// In pl, this message translates to:
  /// **'Symbol o takiej nazwie już istnieje'**
  String get duplicateSymbolExists;

  /// No description provided for @labelRequired.
  ///
  /// In pl, this message translates to:
  /// **'Proszę wprowadzić nazwę symbolu'**
  String get labelRequired;

  /// No description provided for @linkBoards.
  ///
  /// In pl, this message translates to:
  /// **'Podlinkuj tablice:'**
  String get linkBoards;

  /// No description provided for @noImageTitle.
  ///
  /// In pl, this message translates to:
  /// **'Nie dodałeś obrazka'**
  String get noImageTitle;

  /// No description provided for @noImageQuestion.
  ///
  /// In pl, this message translates to:
  /// **'Czy chcesz to zrobić teraz?'**
  String get noImageQuestion;

  /// No description provided for @boardNameRequired.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa nie może być pusta'**
  String get boardNameRequired;

  /// No description provided for @boardNameExists.
  ///
  /// In pl, this message translates to:
  /// **'Tablica o takiej nazwie już istnieje'**
  String get boardNameExists;

  /// No description provided for @name.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa'**
  String get name;

  /// No description provided for @columnsPositive.
  ///
  /// In pl, this message translates to:
  /// **'Liczba kolumn powinna być większa od 0'**
  String get columnsPositive;

  /// No description provided for @columnsCount.
  ///
  /// In pl, this message translates to:
  /// **'Liczba Kolumn'**
  String get columnsCount;

  /// No description provided for @cropImage.
  ///
  /// In pl, this message translates to:
  /// **'Przycinanie zdjęcia'**
  String get cropImage;

  /// No description provided for @removeImage.
  ///
  /// In pl, this message translates to:
  /// **'Usuń obraz'**
  String get removeImage;

  /// No description provided for @cropImageAction.
  ///
  /// In pl, this message translates to:
  /// **'Przytnij obraz'**
  String get cropImageAction;

  /// No description provided for @replaceImage.
  ///
  /// In pl, this message translates to:
  /// **'Zamień obraz'**
  String get replaceImage;

  /// No description provided for @addNewBoard.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj nową'**
  String get addNewBoard;

  /// No description provided for @findExistingBoard.
  ///
  /// In pl, this message translates to:
  /// **'Wyszukaj istniejącą'**
  String get findExistingBoard;

  /// No description provided for @searchArasaac.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj w Arasaac'**
  String get searchArasaac;

  /// No description provided for @arasaacEmptyTitle.
  ///
  /// In pl, this message translates to:
  /// **'Oj mój... jak tu pusto'**
  String get arasaacEmptyTitle;

  /// No description provided for @arasaacEmptySubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Pora coś wyszukać, bo ta pustka jest ciut niezręczna'**
  String get arasaacEmptySubtitle;

  /// No description provided for @arasaacTab.
  ///
  /// In pl, this message translates to:
  /// **'Arasaac'**
  String get arasaacTab;

  /// No description provided for @deviceTab.
  ///
  /// In pl, this message translates to:
  /// **'Urządzenie'**
  String get deviceTab;

  /// No description provided for @linkTab.
  ///
  /// In pl, this message translates to:
  /// **'Link'**
  String get linkTab;

  /// No description provided for @pasteImageLink.
  ///
  /// In pl, this message translates to:
  /// **'Wklej link do obrazka'**
  String get pasteImageLink;

  /// No description provided for @invalidUrl.
  ///
  /// In pl, this message translates to:
  /// **'Niepoprawny adres url'**
  String get invalidUrl;

  /// No description provided for @camera.
  ///
  /// In pl, this message translates to:
  /// **'Aparat'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In pl, this message translates to:
  /// **'Galeria'**
  String get gallery;

  /// No description provided for @searchLanguage.
  ///
  /// In pl, this message translates to:
  /// **'Język wyszukiwania'**
  String get searchLanguage;

  /// No description provided for @deleteForeverConfirm.
  ///
  /// In pl, this message translates to:
  /// **'Czy jesteś pewien? Operacji nie da się odwrócić'**
  String get deleteForeverConfirm;

  /// No description provided for @boardPreview.
  ///
  /// In pl, this message translates to:
  /// **'Podgląd tablicy'**
  String get boardPreview;

  /// No description provided for @downloadFailed.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się pobrać obrazka'**
  String get downloadFailed;

  /// No description provided for @notAnImage.
  ///
  /// In pl, this message translates to:
  /// **'Podany url nie jest obrazkiem'**
  String get notAnImage;

  /// No description provided for @saveImageFailed.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się zapisać obrazka'**
  String get saveImageFailed;

  /// No description provided for @noResultsFor.
  ///
  /// In pl, this message translates to:
  /// **'Hmm.. nie znaleźliśmy wyników dla \"{query}\"'**
  String noResultsFor(String query);

  /// No description provided for @colorNoun.
  ///
  /// In pl, this message translates to:
  /// **'Rzeczownik'**
  String get colorNoun;

  /// No description provided for @colorAdjective.
  ///
  /// In pl, this message translates to:
  /// **'Przymiotnik'**
  String get colorAdjective;

  /// No description provided for @colorVerb.
  ///
  /// In pl, this message translates to:
  /// **'Czasownik'**
  String get colorVerb;

  /// No description provided for @colorBarbie.
  ///
  /// In pl, this message translates to:
  /// **'Barbie'**
  String get colorBarbie;

  /// No description provided for @colorLucy.
  ///
  /// In pl, this message translates to:
  /// **'Lucy'**
  String get colorLucy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
