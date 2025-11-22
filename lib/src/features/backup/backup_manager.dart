import 'dart:async';

import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/shared/utils/get_app_directory.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;

part 'backup_manager.g.dart';

class BackupManager {
  final _progressStreamController = StreamController<double>();

  Future<void> decompress(String filePath, WidgetRef ref) async {
    await ref.read(dbProvider).close();

    final input = InputFileStream(filePath);

    final appDirectory = await getGadaczDirectory();

    final archive = ZipDecoder().decodeStream(input);

    await appDirectory.delete(recursive: true);

    await extractArchiveToDisk(archive, appDirectory.path);

    final db = ref.refresh(dbProvider);

    await ref.read(settingsCacheProvider).initializeStore(db);
  }

  Future<void> compress() async {
    final encoder = ZipFileEncoder();

    final appDirectory = await getGadaczDirectory();
    final backupDirectory = await getTemporaryDirectory();

    final filename = p.join(backupDirectory.path,
        "gadacz-backup-${DateTime.now().toIso8601String()}.zip");

    await encoder.zipDirectory(appDirectory, filename: filename,
        onProgress: (e) {
      _progressStreamController.add(e);
    });

    await OpenFile.open(filename, type: "text/html");
  }

  Stream<double> get stream {
    return _progressStreamController.stream;
  }
}

@riverpod
BackupManager backupManager(Ref ref) {
  return BackupManager();
}

@riverpod
Stream<double> backupProgress(Ref ref) {
  final manager = ref.watch(backupManagerProvider);
  return manager.stream;
}
