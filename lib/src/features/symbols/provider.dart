import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final symbolManagerProvider = FutureProvider<SymbolManager>((ref) async {
  final isar = await ref.watch(isarPod.future);
  return SymbolManager(isar: isar);
});

final symbolsProvider = StreamProvider.family<List<CommunicationSymbol>, Id>(
    (ref, parentBoardId) async* {
  final manager = await ref.watch(symbolManagerProvider.future);
  yield* manager.watchSymbols(parentBoardId);
});
