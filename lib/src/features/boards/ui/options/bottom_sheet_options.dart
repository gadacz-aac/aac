import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/settings/ui/settings_screen.dart';
import 'package:aac/src/features/settings/utils/protective_mode.dart';
import 'package:aac/src/features/symbols/bin/bin_screen.dart';
import 'package:aac/src/features/symbols/settings/screens/create_board_screen.dart';
import 'package:aac/src/features/symbols/settings/utils/randomise_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetOptions extends StatelessWidget {
  const BottomSheetOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const OptionGroup(
            options: [
              LockOption(),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          OptionGroup(options: [
            const OpenSettingsOption(),
            Option(
              icon: const Icon(Icons.delete),
              label: "Kosz",
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const BinScreen())),
            )
          ]),
          const SizedBox(
            height: 24,
          ),
          const OptionGroup(options: [
            EditBoardOption(),
          ]),
          if (kDebugMode) ...[
            const SizedBox(
              height: 24,
            ),
            const OptionGroup(
              options: [CreateRandomSymbol()],
            )
          ]
        ]),
      ),
    );
  }
}

class CreateRandomSymbol extends ConsumerWidget {
  const CreateRandomSymbol({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Option(
      onTap: () async {
        // final number = await showDialog(
        //     context: context,
        //     builder: (context) => Material(
        //           child: TextField(onSubmitted: (val) {
        //             print("dssdcdscs $val");
        //             Navigator.pop(context, val);
        //           }),
        //         ));

        var number = "12";
        for (int i = 0; i < (int.tryParse(number) ?? 1); i++) {
          randomiseSymbol(ref);
        }
        Navigator.pop(context);
      },
      label: "Dodaj jakieś symbole",
      icon: const Icon(Icons.shuffle),
    );
  }
}

class EditBoardOption extends ConsumerWidget {
  const EditBoardOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardId = ref.watch(boardIdProvider);
    final board = ref.watch(boardProvider(boardId)).valueOrNull;
    final manager = ref.watch(boardManagerProvider);

    return Option(
        onTap: board != null
            ? () async {
                Navigator.pop(context);
                final editingParams = await showModalBottomSheet(
                    context: context,
                    // we don't use any scrollable thing there, but it allows for the boxConstrains to take effect
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (modalContext) {
                      return CreateBoardScreen(
                          params: BoardEditingParams.fromBoard(board));
                    });

                if (editingParams != null) {
                  manager.createOrUpdate(editingParams);
                }
              }
            : null,
        icon: const Icon(Icons.edit),
        label: "Edytuj tablice");
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
        onTap: () async {
          ref.read(isParentModeProvider.notifier).state = false;
          startProtectiveModeIfEnabled(ref);
          Navigator.pop(context);
        });
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
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SettingsScreen())),
    );
  }
}

class Option extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function()? onTap;

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
        if (onTap != null) onTap!();
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
