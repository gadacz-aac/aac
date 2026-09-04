// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get cancel => 'Anuluj';

  @override
  String get save => 'Zapisz';

  @override
  String get yes => 'Tak';

  @override
  String get no => 'Nie';

  @override
  String get delete => 'Usuń';

  @override
  String get deleteForever => 'Usuń na zawsze';

  @override
  String get restore => 'Przywróć';

  @override
  String get settings => 'Ustawienia';

  @override
  String get open => 'Otwórz';

  @override
  String get edit => 'Edytuj';

  @override
  String get defaultLabel => 'Domyślny';

  @override
  String get search => 'Szukaj';

  @override
  String get unpin => 'Odepnij';

  @override
  String get pin => 'Przypnij';

  @override
  String get confirm => 'Zatwierdź';

  @override
  String errorPrefix(String error) {
    return 'Błąd: $error';
  }

  @override
  String get oops => 'Oops..';

  @override
  String boardNotFound(int id) {
    return 'Nie znaleziono tablicy o id $id';
  }

  @override
  String lockHint(int count) {
    return 'Stuknij jeszcze $count razy, aby wyjść z trybu ochrony';
  }

  @override
  String get symbolsTab => 'Symbole';

  @override
  String get boardsTab => 'Tablice';

  @override
  String noMatching(String what) {
    return 'Brak pasujących $what';
  }

  @override
  String someDeleted(String what) {
    return 'Część $what mogła zostać usunięta';
  }

  @override
  String get symbolsGenitive => 'symboli';

  @override
  String get boardsGenitive => 'tablic';

  @override
  String get searchBoards => 'Szukaj w tablicach';

  @override
  String get unpinnedChip => 'Nieprzypięte';

  @override
  String get colorChip => 'Kolor';

  @override
  String get bin => 'Kosz';

  @override
  String get addSomeSymbols => 'Dodaj jakieś symbole';

  @override
  String get editBoard => 'Edytuj tablicę';

  @override
  String get lock => 'Zablokuj';

  @override
  String get deleteBoardsTitle => 'Usuń tablice i symbole';

  @override
  String get chooseSymbolsToBin =>
      'Wybierz symbole, które chcesz \nprzenieść do kosza';

  @override
  String get rememberRestorable => 'Pamiętaj, że możesz je zawsze przywrócić';

  @override
  String get restoreBoardTitle => 'Przywróć tablicę i symbole';

  @override
  String get chooseSymbolsToRestore =>
      'Wybierz symbole, które chcesz \nprzywrócić';

  @override
  String get deleteBoardTitle => 'Usuń tablicę i symbole';

  @override
  String get chooseSymbolsToDelete => 'Wybierz symbole, które chcesz \nusunąć';

  @override
  String get viewPreview => 'Zobacz podgląd';

  @override
  String get noDeletedBoards => 'Brak usuniętych tablic';

  @override
  String get noDeletedSymbols => 'Brak usuniętych symboli';

  @override
  String get binEmpty => 'Kosz jest pusty';

  @override
  String get preferences => 'Preferencje';

  @override
  String get blockAppExit => 'Blokuj wyłączanie aplikacji';

  @override
  String get blockAppExitSubtitle =>
      'Nie pozwala na opuszczenie aplikacji w trybie mowy';

  @override
  String get keepScreenOn => 'Nie wygaszaj ekranu';

  @override
  String get keepScreenOnSubtitle => 'Wyłącza automatyczne wygaszanie ekranu';

  @override
  String get orientation => 'Orientacja';

  @override
  String get portrait => 'Pionowa';

  @override
  String get landscape => 'Pozioma';

  @override
  String get autoRotate => 'Autoobracanie ekranu';

  @override
  String get labelPosition => 'Pozycja podpisu';

  @override
  String get labelPositionUnder => 'Pod obrazkiem';

  @override
  String get labelPositionOver => 'Nad obrazkiem';

  @override
  String get language => 'Język';

  @override
  String get languagePolish => 'Polski';

  @override
  String get languageEnglish => 'Angielski';

  @override
  String get speechSettings => 'Ustawienia mowy';

  @override
  String get voicePitch => 'Wysokość głosu';

  @override
  String get speechRate => 'Prędkość mowy';

  @override
  String get synthVoice => 'Głos syntezatora';

  @override
  String get voice => 'Głos';

  @override
  String get voiceChangeUnavailable =>
      'W tej chwili nie możesz zmienić domyślnego głosu';

  @override
  String get exportImport => 'Eksport i import';

  @override
  String get backup => 'Kopia zapasowa';

  @override
  String get backupSubtitle => 'Eksportuj lub importuj ustawienia aplikacji';

  @override
  String get export => 'Eksportuj';

  @override
  String get import => 'Importuj';

  @override
  String get label => 'Podpis';

  @override
  String get vocalization => 'Wokalizacja (opcjonalnie)';

  @override
  String get vocalizationHelper => 'Co powiedzieć po naciśnięciu?';

  @override
  String get duplicateSymbolExists => 'Symbol o takiej nazwie już istnieje';

  @override
  String get labelRequired => 'Proszę wprowadzić nazwę symbolu';

  @override
  String get linkBoards => 'Podlinkuj tablice:';

  @override
  String get noImageTitle => 'Nie dodałeś obrazka';

  @override
  String get noImageQuestion => 'Czy chcesz to zrobić teraz?';

  @override
  String get boardNameRequired => 'Nazwa nie może być pusta';

  @override
  String get boardNameExists => 'Tablica o takiej nazwie już istnieje';

  @override
  String get name => 'Nazwa';

  @override
  String get columnsPositive => 'Liczba kolumn powinna być większa od 0';

  @override
  String get columnsCount => 'Liczba Kolumn';

  @override
  String get cropImage => 'Przycinanie zdjęcia';

  @override
  String get removeImage => 'Usuń obraz';

  @override
  String get cropImageAction => 'Przytnij obraz';

  @override
  String get replaceImage => 'Zamień obraz';

  @override
  String get addNewBoard => 'Dodaj nową';

  @override
  String get findExistingBoard => 'Wyszukaj istniejącą';

  @override
  String get searchArasaac => 'Szukaj w Arasaac';

  @override
  String get arasaacEmptyTitle => 'Oj mój... jak tu pusto';

  @override
  String get arasaacEmptySubtitle =>
      'Pora coś wyszukać, bo ta pustka jest ciut niezręczna';

  @override
  String get arasaacTab => 'Arasaac';

  @override
  String get deviceTab => 'Urządzenie';

  @override
  String get linkTab => 'Link';

  @override
  String get pasteImageLink => 'Wklej link do obrazka';

  @override
  String get invalidUrl => 'Niepoprawny adres url';

  @override
  String get camera => 'Aparat';

  @override
  String get gallery => 'Galeria';

  @override
  String get searchLanguage => 'Język wyszukiwania';

  @override
  String get deleteForeverConfirm =>
      'Czy jesteś pewien? Operacji nie da się odwrócić';

  @override
  String get boardPreview => 'Podgląd tablicy';

  @override
  String get downloadFailed => 'Nie udało się pobrać obrazka';

  @override
  String get notAnImage => 'Podany url nie jest obrazkiem';

  @override
  String get saveImageFailed => 'Nie udało się zapisać obrazka';

  @override
  String noResultsFor(String query) {
    return 'Hmm.. nie znaleźliśmy wyników dla \"$query\"';
  }

  @override
  String get colorNoun => 'Rzeczownik';

  @override
  String get colorAdjective => 'Przymiotnik';

  @override
  String get colorVerb => 'Czasownik';

  @override
  String get colorBarbie => 'Barbie';

  @override
  String get colorLucy => 'Lucy';
}
