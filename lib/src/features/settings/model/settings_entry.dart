class SettingsEntry {
  SettingsEntry({required this.key, dynamic value}) {
    this.value = value;
  }

  int id = 1;
  final String key;
  String? stringValue;
  int? intValue;
  bool? boolValue;
  double? doubleValue;

  dynamic get value => stringValue ?? boolValue ?? doubleValue ?? intValue;

  set value(dynamic value) {
    if (value == null) return;

    switch (value) {
      case String _:
        stringValue = value;
        break;
      case int _:
        intValue = value;
        break;
      case bool _:
        boolValue = value;
        break;
      case double _:
        doubleValue = value;
        break;
      case Enum _:
        stringValue = value.name;
        break;
      default:
        throw UnsupportedError(
            "setting entry can't be of type ${value.runtimeType}");
    }
  }
}
