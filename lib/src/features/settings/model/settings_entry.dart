import 'package:isar/isar.dart';

part 'settings_entry.g.dart';

@collection
class SettingsEntry {
  SettingsEntry({required this.key, dynamic value}) {
    this.value = value;
  }

  Id id = Isar.autoIncrement;
  @Index(
      unique: true, replace: true, caseSensitive: false, type: IndexType.hash)
  final String key;
  String? stringValue;
  int? intValue;
  bool? boolValue;

  @ignore
  dynamic get value => stringValue ?? boolValue ?? intValue;

  set value(dynamic value) {
    if (value == null) return;
    if (value is String) {
      stringValue = value;
    } else if (value is int) {
      intValue = value;
    } else if (value is bool) {
      boolValue = value;
    } else if (value is Enum) {
      stringValue = value.name;
    }
  }
}
