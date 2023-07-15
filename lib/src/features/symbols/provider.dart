import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final symbolManagerProvider = Provider<SymbolManager>((ref) {
  final isar = ref.watch(isarPod);
  return SymbolManager(isar: isar);
});

final symbolsProvider = StreamProvider.family<List<CommunicationSymbol>, Id>(
    (ref, parentBoardId) async* {
  final manager = ref.watch(symbolManagerProvider);
  yield* manager.watchSymbols(parentBoardId);
});
