import 'dart:developer';
import 'dart:io';

import 'package:aac/src/shared/utils/get_app_directory.dart';
import 'package:path/path.dart' as path;

const String defaultImagePath = "assets/default_image_file.png";

Future<String> saveImage(String imagePath, [String? label]) async {
  if (imagePath.startsWith('assets')) {
    return defaultImagePath;
  }

  final imageFile = File(imagePath);

  final appDir = await getGadaczDirectory();
  final newFileName = label != null
      ? transformToFileName(label)
      : path.basename(imageFile.path);

  final newFilePath = path.join(appDir.path, newFileName);

  // if the file already exists you can't copy it to the same file
  if (File(newFilePath).existsSync()) return newFilePath;

  final savedImage = await imageFile.copy(newFilePath);
  log('sciezka do zapisanego obrazu na urzadzeniu: $savedImage $newFileName');
  return savedImage.path;
}

String transformToFileName(String input) {
  //add a timestamp to the file name to avoid duplicates
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final fileName =
      '${input.replaceAll(' ', '_').replaceAll(RegExp(r'[^A-Za-z0-9]'), '#')}_$timestamp.png';
  return fileName;
}
