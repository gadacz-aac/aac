import 'package:aac/model/board.dart';
import 'package:aac/model/communication_symbol.dart';
import 'package:aac/symbol_manager.dart';
import 'package:aac/tts_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final isarPod = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([CommunicationSymbolSchema, BoardSchema],
      directory: dir.path);

  // isar.collection<Board>().export
  isar.writeTxn(() async {
    final board = await isar.boards.get(1);
    if (board == null) {
      await isar.boards.put(Board());
    }
  });

  return isar;
});

final symbolManagerProvider = FutureProvider<SymbolManager>((ref) async {
  final isar = await ref.watch(isarPod.future);
  return SymbolManager(isar: isar);
});

final symbolsProvider = StreamProvider.family<List<CommunicationSymbol>, Id>(
    (ref, parentBoardId) async* {
  final manager = await ref.watch(symbolManagerProvider.future);
  yield* manager.watchSymbols(parentBoardId);
});

final ttsManagerProvider = Provider<TtsManager>((ref) => TtsManager());

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

  void addWord(CommunicationSymbolDto word) {
    state = [...state, word];
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
