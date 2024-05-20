import 'dart:io';

import 'package:aac/src/features/symbols/settings/screens/image_provider.dart';
import 'package:aac/src/features/symbols/settings/utils/file_helpers.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_picker.dart';
import 'package:aac/src/features/symbols/settings/widgets/color_picker.dart';
import 'package:aac/src/features/symbols/settings/widgets/preview_symbol_image.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'symbol_settings.g.dart';

@riverpod
String defaultImagePath(DefaultImagePathRef ref) =>
    "assets/default_image_file.png";

@Riverpod(dependencies: [])
SymbolEditingParams initialValues(InitialValuesRef ref) {
  return const SymbolEditingParams();
}

final labelProvider = StateProvider.autoDispose<String>(
    (ref) => ref.watch(initialValuesProvider).label ?? "",
    dependencies: [initialValuesProvider]);

class SymbolSettings extends ConsumerStatefulWidget {
  final void Function(SymbolEditingParams) updateSymbolSettings;
  const SymbolSettings({super.key, required this.updateSymbolSettings});

  @override
  ConsumerState<SymbolSettings> createState() => _SymbolSettingsState();
}

class _SymbolSettingsState extends ConsumerState<SymbolSettings> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController vocalizationController;

  @override
  void initState() {
    super.initState();

    vocalizationController = TextEditingController(
        text: ref.read(initialValuesProvider).vocalization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SymbolSettingsAppBar(
        submit: submit,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(height: 28),
            const PreviewSymbolImage(),
            const SizedBox(height: 28),
            const LabelTextField(),
            const SizedBox(
              height: 14,
            ),
            GenericTextField(
              controller: vocalizationController,
              name: "vocalization",
              labelText: "Wokalizacja (opcjonalnie)",
              helperText: "Co powiedzieć po naciśnięciu?",
            ),
            const SizedBox(
              height: 14.0,
            ),
            const ColorPicker(),
            const SizedBox(
              height: 28,
            ),
            Text("Podlinkuj tablice:",
                style: Theme.of(context).textTheme.labelLarge),
            const BoardPicker(),
          ],
        ),
      ),
    );
  }

  void submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final imagePath = ref.read(imageNotifierProvider);

    if (imagePath.isEmpty || !File(imagePath).existsSync()) {
      if (!mounted) return;

      showDialog(
          context: context,
          builder: (BuildContext context) => NoImageSelectedDialog(ref: ref));

      return;
    }

    final params = SymbolEditingParams(
        imagePath: await saveImage(imagePath),
        label: ref.read(labelProvider),
        color: ref.read(colorProvider),
        vocalization: vocalizationController.text,
        childBoard: ref.read(boardNotifierProvider));

    widget.updateSymbolSettings(params);
  }
}

class NoImageSelectedDialog extends StatelessWidget {
  const NoImageSelectedDialog({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text(
          "You didn't choose a symbol. Would you like to use the default symbol?"),
      actions: [
        TextButton(
            onPressed: () {
              // widget.updateSymbolSettings(params); // TODO dupa
              // Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              ref.read(imageNotifierProvider.notifier).cherryPick(context);
            },
            child: const Text('No'))
      ],
    );
  }
}

class LabelTextField extends ConsumerWidget {
  const LabelTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(initialValuesProvider).label;
    return GenericTextField(
      name: "label",
      labelText: "Podpis",
      initalValue: label,
      onChanged: (value) => ref.read(labelProvider.notifier).state = value,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Proszę wprowadzić nazwę symbolu';
        }
        return null;
      },
    );
  }
}

class SymbolSettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SymbolSettingsAppBar({super.key, required this.submit});

  final void Function() submit;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppBarTextAction(
                  onTap: Navigator.of(context).pop,
                  child: const Text(
                    "Anuluj",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                AppBarTextAction(
                  onTap: submit,
                  child: const Text(
                    "Zapisz",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ]),
        ));
  }
}

class AppBarTextAction extends StatelessWidget {
  const AppBarTextAction({super.key, this.onTap, this.child});

  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(child: child),
      ),
    );
  }
}
