import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/text_to_speech/tts_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ttsManagerProvider = Provider<TtsManager>((ref) {
  return TtsManager();
});

@immutable
class CommunicationSymbolDto {
  const CommunicationSymbolDto({required this.label, required this.imagePath});

  final String label;
  final String imagePath;
}

class SentenceNotifier extends Notifier<List<CommunicationSymbolDto>> {
  @override
  List<CommunicationSymbolDto> build() {
    return [];
  }

  void addWord(CommunicationSymbol word) {
    final dto =
        CommunicationSymbolDto(label: word.label, imagePath: word.imagePath);
    state = [...state, dto];
  }

  void removeLastWord() {
    if (state.isEmpty) return;
    state = state.sublist(0, state.length - 1);
  }

  void clear() {
    state = [];
  }
}

final sentenceNotifierProvider =
    NotifierProvider<SentenceNotifier, List<CommunicationSymbolDto>>(() {
  return SentenceNotifier();
});
