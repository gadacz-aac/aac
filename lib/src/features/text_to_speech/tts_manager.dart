import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

final ttsManagerProvider = Provider<TtsManager>((ref) {
  final settingsManger = ref.watch(settingsManagerProvider);
  return TtsManager(settingsManager: settingsManger);
});

class TtsManager {
  final SettingsManager settingsManager;
  final tts = FlutterTts();

  bool isFirstTime = true;
  String locale = 'pl-PL';

  TtsManager({required this.settingsManager});

  Future<void> setDefaultOptions() async {
    await Future.wait([
      tts.setVolume(1),
      tts.setSpeechRate(0.5),
      tts.setPitch(1),
      tts.setLanguage(locale),
      tts.setQueueMode(1),
      tts.awaitSpeakCompletion(true),
      setPreferredVoice()
    ]);
  }

  Future<void> setPreferredVoice() async {
    final voice = await settingsManager.getValue('voice');
    if (voice == null) return;
    await setVoice(voice);
  }

  Future<void> setVoice(String name) async {
    await tts.setVoice({'name': name, 'locale': locale});
  }

  Future<void> _speak(String word) async {
    // becuase of setup there might be a little
    // delay before first utterance is played
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
