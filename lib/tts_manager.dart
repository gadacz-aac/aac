import 'package:aac/providers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  late final FlutterTts tts;
  List<String> queue = [];

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

  Future<void> sayWord(String word) async {
    await tts.speak(word);
  }

  Future<void> saySentence(List<CommunicationSymbolDto> sentence) async {
    final words = sentence.map((e) => e.label);
    await tts.speak(words.join(' '));
  }
}
