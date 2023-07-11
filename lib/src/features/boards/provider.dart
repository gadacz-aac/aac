import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final boardManagerProvider = FutureProvider((ref) async {
  final isar = await ref.watch(isarPod.future);
  return BoardManager(isar: isar);
});

final boardCrossAxisCountProvider =
    FutureProvider.family<int, Id>((ref, boardId) async {
  final boardManager = await ref.watch(boardManagerProvider.future);
  return await boardManager.getCrossAxisCount(boardId);
});
