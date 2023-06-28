import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  late final FlutterTts tts;

  TtsManager() {
    tts = FlutterTts();
    setDefaultOptions();
  }

  Future<void> setDefaultOptions() async {
    await tts.setVolume(1);
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);
    await tts.setLanguage('pl-PL');
  }

  Future<void> speak(List<String> sentence) async {
    await tts.speak(sentence.join(' '));
  }
}
