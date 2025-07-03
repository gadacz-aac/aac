import 'dart:async';
import 'dart:io';

import 'package:aac/src/database/database.dart';
import 'package:aac/src/features/settings/settings_manager.dart';
import 'package:aac/src/shared/utils/get_app_directory.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;

part 'backup_manager.g.dart';

class Backup {
  final String path;
  late final String name;
  late final DateTime date;

  Backup({required this.path}) {
    name = p.split(path).last.split(".").first;
    date = DateTime.parse(name.split("gadacz-backup-").last);
  }
}

class BackupManager {
  final _progressStreamController = StreamController<double>();

  Future<Directory> getBackupDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    final backupDirectory = Directory(p.join(directory.path, "backup"));

    if (!backupDirectory.existsSync()) {
      backupDirectory.createSync();
    }

    return backupDirectory;
  }

  decompress(Backup backup, WidgetRef ref) async {
    await ref.read(dbProvider).close();

    final input = InputFileStream(backup.path);

    final appDirectory = await getGadaczDirectory();

    final archive = ZipDecoder().decodeStream(input);

    await appDirectory.delete(recursive: true);

    await extractArchiveToDisk(archive, appDirectory.path);

    final db = ref.refresh(dbProvider);

    await ref.read(settingsCacheProvider).initializeStore(db);
  }

  compress() async {
    final encoder = ZipFileEncoder();

    final appDirectory = await getGadaczDirectory();
    final backupDirectory = await getBackupDirectory();
    final filename = p.join(backupDirectory.path,
        "gadacz-backup-${DateTime.now().toIso8601String()}.zip");

    await encoder.zipDirectory(appDirectory, filename: filename,
        onProgress: (e) {
      _progressStreamController.add(e);
    });
  }

  Future<List<Backup>> getBackupList() async {
    return (await getBackupDirectory())
        .list()
        .map((e) => Backup(path: e.path))
        .toList();
  }

  get stream {
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
