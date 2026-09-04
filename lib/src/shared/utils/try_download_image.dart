import 'dart:io';

import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/shared/utils/get_random_string.dart';
import 'package:path_provider/path_provider.dart';

/// Errors returned by [tryDownloadImage], meant to be localized by the caller.
enum DownloadImageError { downloadFailed, notAnImage, saveFailed }

/// Download an image from [uri] and save it to temporary directory, it's your resposibility to move it somewhere safe
/// Retuns File or an error if something went wrong, if there was an error file is null and vice versa
Future<(File?, DownloadImageError?)> tryDownloadImage(Uri uri) async {
  HttpClientResponse response;

  try {
    final request = await HttpClient().getUrl(uri);
    response = await request.close();
  } catch (e) {
    return (null, DownloadImageError.downloadFailed);
  }

  final contentType = response.headers.contentType;

  if (contentType == null || !isValidImage(contentType)) {
    return (null, DownloadImageError.notAnImage);
  }

  File file;
  final tempDir = await getTemporaryDirectory();
  do {
    final fileName = getRandomString(8);
    file = File('${tempDir.path}/$fileName.${contentType.subType}');
  } while (file.existsSync());

  try {
    await response.pipe(file.openWrite());
  } catch (e) {
    return (null, DownloadImageError.saveFailed);
  }

  return (file, null);
}