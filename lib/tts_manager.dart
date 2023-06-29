import 'package:aac/providers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  late final FlutterTts tts;
  bool isFirstTime = true;

  TtsManager() {
    tts = FlutterTts();
  }

  Future<void> setDefaultOptions() async {
    await tts.setVolume(1);
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);
    await tts.setLanguage('pl-PL');
    await tts.setQueueMode(1);
    await tts.awaitSpeakCompletion(true);
  }

  Future<void> _speak(String word) async {
    if (isFirstTime) {
      isFirstTime = false;
      await setDefaultOptions();
    }
    await tts.speak(word);
  }

  Future<void> sayWord(String word) async {
    await _speak(word);
  }

  Future<void> saySentence(List<CommunicationSymbolDto> sentence) async {
    final words = sentence.map((e) => e.label);
    await _speak(words.join(' '));
  }
}
