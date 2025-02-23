import 'package:flutter_tts/flutter_tts.dart';

Future<List<String>> getVoicesNames() async {
  final tts = FlutterTts();
  final voices = await tts.getVoices;
  List<String> polishVoices = [];
  for (Map voice in voices) {
    if (voice["locale"] == 'pl-PL') polishVoices.add(voice["name"]);
  }

  return polishVoices;
}
