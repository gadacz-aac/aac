import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/text_to_speech/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tts_manager.g.dart';

@riverpod
TtsManager ttsManager(Ref ref) {
  final settingsManger = ref.watch(settingsManagerProvider);
  return TtsManager(settingsManager: settingsManger);
}

class TtsManager {
  final SettingsManager settingsManager;
  final tts = FlutterTts();

  bool isFirstTime = true;
  String locale = 'pl-PL';

  TtsManager({required this.settingsManager});

  Future<void> setDefaultOptions() async {
    await Future.wait([
      tts.setVolume(1),
      tts.setSpeechRate(1),
      tts.setPitch(1),
      tts.setLanguage(locale),
      tts.setQueueMode(1),
      tts.awaitSpeakCompletion(true),
      setPreferredVoice(),
      setPreferredSpeechRate()
    ]);
  }

  Future<void> setPreferredVoice() async {
    final String? voice = await settingsManager.getValue(SettingKey.voice.name);
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

  Future<void> sayWord(CommunicationSymbol symbol) async {
    await _speak(
        (symbol.vocalization != null && symbol.vocalization!.isNotEmpty)
            ? symbol.vocalization!
            : symbol.label);
  }

  Future<void> saySentence(List<CommunicationSymbolDto> sentence) async {
    final words = sentence.map((e) =>
        (e.vocalization != null && e.vocalization!.isNotEmpty)
            ? e.vocalization!
            : e.label);
    await _speak(words.join(' '));
  }

  Future<void> setPreferredSpeechRate() async {
    final double savedRate =
        await settingsManager.getValue(SettingKey.speechRate.name);
    await tts.setSpeechRate(savedRate);
  }

  Future<void> setSpeechRate(double rate) async {
    await tts.setSpeechRate(rate);
  }
}
