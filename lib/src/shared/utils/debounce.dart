import 'dart:async';

class Debouncer {
  Timer? _timer;
  final Duration _duration;

  Debouncer(this._duration);

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(_duration, () => callback());
  }

  void dispose() {
    _timer?.cancel();
  }
}
