import 'package:isar/isar.dart';

part 'settings_entry.g.dart';

@collection
class SettingsEntry {
  SettingsEntry(
      {required this.key, this.stringValue, this.boolValue, this.intValue});

  Id id = Isar.autoIncrement;
  @Index(
      unique: true, replace: true, caseSensitive: false, type: IndexType.hash)
  final String key;
  final String? stringValue;
  final int? intValue;
  final bool? boolValue;

  @ignore
  dynamic get value => stringValue ?? intValue ?? boolValue;
}
