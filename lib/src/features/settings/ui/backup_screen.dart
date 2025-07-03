import 'package:aac/src/features/backup/backup_manager.dart';
import 'package:aac/src/features/settings/ui/widgets/group.dart';
import 'package:aac/src/shared/padding.dart';
import 'package:aac/src/shared/ui/button.dart';
import 'package:aac/src/shared/ui/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackupGroup extends PersistentGroup {
  const BackupGroup({
    super.key,
    super.title = const Text("Eksport i import"),
    super.children = const [
      SettingGroupLink(
          title: "Eksportuj ustawienia",
          subtitle: "Eksportuj ustawienia do pliku",
          child: BackupScreen()),
    ],
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
    final backups = ref.watch(backupManagerProvider).getBackupList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Eksport i import"),
        ),
        body: Column(children: [
          PersistentGroup(
              isFirst: true,
              title: const Text("Kopia zapasowa"),
              subtitle:
                  const Text("Eksportuj lub importuj ustawienia aplikacji"),
              children: [
                Padding(
                  padding: AacPaddings.horizontal16,
                  child: AacButton(
                      onPressed: () =>
                          ref.read(backupManagerProvider).compress(),
                      child: const Text(
                        "Eksportuj",
                      )),
                )
              ]),
          Expanded(
            child: PersistentGroup(
                title: Text("Dostępne kopie zapasowe"),
                children: [
                  FutureBuilder(
                      future: backups,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              "Błąd podczas ładowania kopii zapasowych: ${snapshot.error}");
                        }

                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const Text(
                              "Brak dostępnych kopii zapasowych.");
                        }

                        final backups = snapshot.data!;
                        return Expanded(
                          child: AacList(
                              itemBuilder: (context, index) {
                                return AacListTile(
                                    title: Text(backups[index].name),
                                    subtitle: Text("Lokalny"),
                                    trailing: Icon(Icons.chevron_right_rounded),
                                    isFirst: index == 0,
                                    onTap: () => showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(26.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                    "Kopia zapasowa: ${backups[index].date}",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium),
                                                Text(
                                                    "Aplikacja zostanie przywrócona do stanu z tej kopii zapasowej. Obecne zmiany zostaną utracone",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge),
                                                AacButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(
                                                            backupManagerProvider)
                                                        .decompress(
                                                            backups[index],
                                                            ref);

                                                    if (context.mounted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text("Przywróć"),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    isLast: index == backups.length - 1);
                              },
                              itemCount: backups.length),
                        );
                      })
                ]),
          )
        ]));
  }
}
