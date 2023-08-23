import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

const String defaultImagePath = "assets/default_image_file.png";

Future<String> saveImage(String imagePath, [String? label]) async {
  if (imagePath.startsWith('assets')) {
    return defaultImagePath;
  }

  final imageFile = File(imagePath);
  final appDir = await getApplicationDocumentsDirectory();
  final fileName = label != null
      ? transformToFileName(label)
      : path.basename(imageFile.path);
  final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  log('sciezka do zapisanego obrazu na urzadzeniu: $savedImage $fileName');
  return savedImage.path;
}

String transformToFileName(String input) {
  //add a timestamp to the file name to avoid duplicates
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final fileName =
      '${input.replaceAll(' ', '_').replaceAll(RegExp(r'[^A-Za-z0-9]'), '#')}_$timestamp.png';
  return fileName;
}
