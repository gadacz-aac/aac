import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boardManagerProvider = Provider((ref) {
  final isar = ref.watch(isarPod);
  return BoardManager(isar: isar);
});

// final boardCrossAxisCountProvider =
//     FutureProvider.family<int, Id>((ref, boardId) async {
//   final boardManager = ref.watch(boardManagerProvider);
//   return await boardManager.getCrossAxisCount(boardId);
// });
