import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<Directory> getGadaczDirectory() async {
  final documents = await getApplicationDocumentsDirectory();
  final appDirectory = Directory(p.join(documents.path, "app"));

  if (!appDirectory.existsSync()) {
    appDirectory.createSync();
  }

  return appDirectory;
}

// ignore: constant_identifier_names
const ANDROID_DOWNLOAD_PATH = "/storage/emulated/0/Download/";
