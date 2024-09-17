import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/utils/protective_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetOptions extends StatelessWidget {
  const BottomSheetOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const OptionGroup(
          options: [
            LockOption(),
            OpenSettingsOption()
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        OptionGroup(options: [
          Option(
            icon: const Icon(Icons.delete),
            label: "Śmietnik",
            onTap: () {},
          )
        ])
      ]),
    );
  }
}

class LockOption extends ConsumerWidget {
  const LockOption({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Option(
      icon: const Icon(Icons.lock),
      label: "Zablokuj",
      onTap: () {
        ref.read(isParentModeProvider.notifier).state = false;
        startProtectiveModeIfEnabled(ref);
      } 
    );
  }
}

class OpenSettingsOption extends StatelessWidget {
  const OpenSettingsOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Option(
      icon: const Icon(Icons.settings),
      label: "Ustawienia",
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SettingsScreen())),
    );
  }
}

class Option extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function() onTap;

  const Option({
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 16,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}

class OptionGroup extends StatelessWidget {
  final List<Widget> options;

  const OptionGroup({
    required this.options,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFE9E9E9);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(width: 1, color: borderColor)),
        child: Column(
          children: options
              .expand((e) => [
                    e,
                    const Divider(
                      color: borderColor,
                      height: 1,
                    )
                  ])
              .toList()
            ..removeLast(),
        ));
  }
}
