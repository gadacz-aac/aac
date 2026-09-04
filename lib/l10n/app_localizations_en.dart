// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get delete => 'Delete';

  @override
  String get deleteForever => 'Delete forever';

  @override
  String get restore => 'Restore';

  @override
  String get settings => 'Settings';

  @override
  String get open => 'Open';

  @override
  String get edit => 'Edit';

  @override
  String get defaultLabel => 'Default';

  @override
  String get search => 'Search';

  @override
  String get unpin => 'Unpin';

  @override
  String get pin => 'Pin';

  @override
  String get confirm => 'Confirm';

  @override
  String errorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get oops => 'Oops..';

  @override
  String boardNotFound(int id) {
    return 'Board with id $id wasn\'t found';
  }

  @override
  String lockHint(int count) {
    return 'Tap $count more times to leave protective mode';
  }

  @override
  String get symbolsTab => 'Symbols';

  @override
  String get boardsTab => 'Boards';

  @override
  String noMatching(String what) {
    return 'No matching $what';
  }

  @override
  String someDeleted(String what) {
    return 'Some of the $what may have been deleted';
  }

  @override
  String get symbolsGenitive => 'symbols';

  @override
  String get boardsGenitive => 'boards';

  @override
  String get searchBoards => 'Search boards';

  @override
  String get unpinnedChip => 'Unpinned';

  @override
  String get colorChip => 'Color';

  @override
  String get bin => 'Bin';

  @override
  String get addSomeSymbols => 'Add some symbols';

  @override
  String get editBoard => 'Edit board';

  @override
  String get lock => 'Lock';

  @override
  String get deleteBoardsTitle => 'Delete board and symbols';

  @override
  String get chooseSymbolsToBin =>
      'Choose symbols you want \nto move to the bin';

  @override
  String get rememberRestorable => 'Remember, you can always restore them';

  @override
  String get restoreBoardTitle => 'Restore board and symbols';

  @override
  String get chooseSymbolsToRestore => 'Choose symbols you want \nto restore';

  @override
  String get deleteBoardTitle => 'Delete board and symbols';

  @override
  String get chooseSymbolsToDelete => 'Choose symbols you want \nto delete';

  @override
  String get viewPreview => 'See preview';

  @override
  String get noDeletedBoards => 'No deleted boards';

  @override
  String get noDeletedSymbols => 'No deleted symbols';

  @override
  String get binEmpty => 'The bin is empty';

  @override
  String get preferences => 'Preferences';

  @override
  String get blockAppExit => 'Block closing the app';

  @override
  String get blockAppExitSubtitle =>
      'Doesn\'t allow leaving the app in speech mode';

  @override
  String get keepScreenOn => 'Keep screen on';

  @override
  String get keepScreenOnSubtitle => 'Disables automatic screen dimming';

  @override
  String get orientation => 'Orientation';

  @override
  String get portrait => 'Portrait';

  @override
  String get landscape => 'Landscape';

  @override
  String get autoRotate => 'Auto-rotate screen';

  @override
  String get labelPosition => 'Label position';

  @override
  String get labelPositionUnder => 'Under the image';

  @override
  String get labelPositionOver => 'Over the image';

  @override
  String get language => 'Language';

  @override
  String get languagePolish => 'Polish';

  @override
  String get languageEnglish => 'English';

  @override
  String get speechSettings => 'Speech settings';

  @override
  String get voicePitch => 'Voice pitch';

  @override
  String get speechRate => 'Speech rate';

  @override
  String get synthVoice => 'Synth voice';

  @override
  String get voice => 'Voice';

  @override
  String get voiceChangeUnavailable =>
      'You can\'t change the default voice right now';

  @override
  String get exportImport => 'Export and import';

  @override
  String get backup => 'Backup';

  @override
  String get backupSubtitle => 'Export or import app settings';

  @override
  String get export => 'Export';

  @override
  String get import => 'Import';

  @override
  String get label => 'Label';

  @override
  String get vocalization => 'Vocalization (optional)';

  @override
  String get vocalizationHelper => 'What to say when pressed?';

  @override
  String get duplicateSymbolExists => 'A symbol with this name already exists';

  @override
  String get labelRequired => 'Please enter a symbol name';

  @override
  String get linkBoards => 'Link boards:';

  @override
  String get noImageTitle => 'You haven\'t added an image';

  @override
  String get noImageQuestion => 'Would you like to do it now?';

  @override
  String get boardNameRequired => 'Name cannot be empty';

  @override
  String get boardNameExists => 'A board with this name already exists';

  @override
  String get name => 'Name';

  @override
  String get columnsPositive => 'Column count should be greater than 0';

  @override
  String get columnsCount => 'Column count';

  @override
  String get cropImage => 'Crop image';

  @override
  String get removeImage => 'Remove image';

  @override
  String get cropImageAction => 'Crop image';

  @override
  String get replaceImage => 'Replace image';

  @override
  String get addNewBoard => 'Add new';

  @override
  String get findExistingBoard => 'Find existing';

  @override
  String get searchArasaac => 'Search Arasaac';

  @override
  String get arasaacEmptyTitle => 'Oh my... it\'s so empty here';

  @override
  String get arasaacEmptySubtitle =>
      'Time to search for something, this emptiness is a bit awkward';

  @override
  String get arasaacTab => 'Arasaac';

  @override
  String get deviceTab => 'Device';

  @override
  String get linkTab => 'Link';

  @override
  String get pasteImageLink => 'Paste an image link';

  @override
  String get invalidUrl => 'Invalid url';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get searchLanguage => 'Search language';

  @override
  String get deleteForeverConfirm =>
      'Are you sure? This action cannot be undone';

  @override
  String get boardPreview => 'Board preview';

  @override
  String get downloadFailed => 'Failed to download the image';

  @override
  String get notAnImage => 'The given url is not an image';

  @override
  String get saveImageFailed => 'Failed to save the image';

  @override
  String noResultsFor(String query) {
    return 'Hmm.. no results for \"$query\"';
  }

  @override
  String get colorNoun => 'Noun';

  @override
  String get colorAdjective => 'Adjective';

  @override
  String get colorVerb => 'Verb';

  @override
  String get colorBarbie => 'Barbie';

  @override
  String get colorLucy => 'Lucy';
}
