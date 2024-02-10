import 'dart:convert';
import 'dart:math';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:word_generator/word_generator.dart';

import 'symbol_manager.dart';

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

String getArrasacImageUrl(String id) {
  return "https://api.arasaac.org/v1/pictograms/$id?backgroundColor=none&download=false";
}

String getRandomSearch() {
  Random random = Random();
  String letters = 'abcdefghijklmnopqrstuvwxyz';

  // Generate a random index for the first letter
  int index1 = random.nextInt(letters.length);

  // Generate a random index for the second letter, ensuring it is different from the first
  int index2 = (index1 + random.nextInt(letters.length - 1)) % letters.length;

  // Create the random string
  String randomString = letters[index1] + letters[index2];

  return randomString;
}

void randomiseSymbol(WidgetRef ref) async {
  final manager = ref.read(symbolManagerProvider);
  final boardId = ref.read(boardIdProvider);
  for (int i = 0; i < 30; i++) {
    final search = getRandomSearch();
    final res = await http.get(
        Uri.parse('https://api.arasaac.org/v1/pictograms/en/search/$search'));

    if (res.ok && res.body.isNotEmpty) {
      final body = jsonDecode(res.body);
      final random = Random();
      final symbol = body[random.nextInt(body.length)];

      manager.saveSymbol(
        boardId,
        SymbolEditingParams(
            imagePath: getArrasacImageUrl("${symbol["_id"]}"),
            label: "${symbol["keywords"][0]["keyword"]}"),
      );
      return;
    }
  }

  final wordGenerator = WordGenerator();
  manager.saveSymbol(
      boardId,
      SymbolEditingParams(
          imagePath: "assets/default_image_file.png",
          label: wordGenerator.randomNoun()));
}
