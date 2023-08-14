import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_generator/word_generator.dart';

void randomiseSymbol(WidgetRef ref, int boardId) async {
  final wordGenerator = WordGenerator();
  final manager = ref.read(symbolManagerProvider);
  manager.saveSymbol(
    boardId,
    label: wordGenerator.randomNoun(),
    imagePath: "assets/default_image_file.png",
    crossAxisCount: 2,
    createChild: false,
  );
}
