import 'dart:io';

import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/shared/utils/get_random_string.dart';
import 'package:path_provider/path_provider.dart';

/// Download an image from [uri] and save it to temporary directory, it's your resposibility to move it somewhere safe
/// Retuns File or an error message if something went wrong, if there was an error file is null and vice versa
Future<(File?, String?)> tryDownloadImage(Uri uri) async {
  HttpClientResponse response;

  try {
    final request = await HttpClient().getUrl(uri);
    response = await request.close();
  } catch (e) {
    return (null, "Nie udało się pobrać obrazka");
  }

  final contentType = response.headers.contentType;

  if (contentType == null || !isValidImage(contentType)) {
    return (null, "Podany url nie jest obrazkiem");
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
    return (null, "Nie udało się zapisać obrazka");
  }

  return (file, null);
}
