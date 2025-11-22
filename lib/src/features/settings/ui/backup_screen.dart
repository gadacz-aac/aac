import 'package:aac/src/features/backup/backup_manager.dart';
import 'package:aac/src/features/settings/ui/widgets/group.dart';
import 'package:aac/src/shared/padding.dart';
import 'package:aac/src/shared/ui/button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackupGroup extends PersistentGroup {
  const BackupGroup({
    super.key,
    super.title = const Text("Eksport i import"),
    super.children = const [BackupScreen()],
  });
}

class SettingGroupLink extends StatelessWidget {
  const SettingGroupLink({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => child)),
    );
  }
}

class BackupScreen extends ConsumerWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AacPaddings.horizontal16,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Kopia zapasowa"),
        const Text("Eksportuj lub importuj ustawienia aplikacji"),
        AacButton(
            onPressed: () => ref.read(backupManagerProvider).compress(),
            child: const Text(
              "Eksportuj",
            )),
        AacButton(
            onPressed: () async {
              final res = await FilePicker.platform
                  .pickFiles(type: FileType.custom, allowedExtensions: ["zip"]);

              final filePath = res?.files.singleOrNull?.path;

              if (filePath == null) {
                return;
              }

              ref.read(backupManagerProvider).decompress(filePath, ref);
            },
            child: const Text(
              "Importuj",
            )),
      ]),
    );
  }
}
