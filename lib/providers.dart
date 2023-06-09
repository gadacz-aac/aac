import 'package:aac/model/communication_symbol.dart';
import 'package:aac/symbol_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final isarPod = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([CommunicationSymbolSchema], directory: dir.path);
});

final symbolManagerProvider = FutureProvider<SymbolManager>((ref) async {
  final isar = await ref.watch(isarPod.future);
  return SymbolManager(isar: isar);
});

final symbolsProvider = StreamProvider<List<CommunicationSymbol>>((ref) async* {
  final manager = await ref.watch(symbolManagerProvider.future);
  yield* manager.watchSymbols();
});
