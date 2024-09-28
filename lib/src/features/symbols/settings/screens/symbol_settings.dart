import 'dart:io';

import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/settings/screens/image_provider.dart';
import 'package:aac/src/features/symbols/settings/utils/file_helpers.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_picker.dart';
import 'package:aac/src/features/symbols/settings/widgets/color_picker.dart';
import 'package:aac/src/features/symbols/settings/widgets/preview_symbol_image.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
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
  final Id boardId;
  const SymbolSettings({super.key, required this.updateSymbolSettings, required this.boardId});

  @override
  ConsumerState<SymbolSettings> createState() => _SymbolSettingsState();
}

class _SymbolSettingsState extends ConsumerState<SymbolSettings> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController vocalizationController;
  String? initialLabel;

  @override
  void initState() {
    super.initState();

    vocalizationController = TextEditingController(
        text: ref.read(initialValuesProvider).vocalization);
    initialLabel = ref.read(initialValuesProvider).label;
  }

  @override
  void dispose() {
    super.dispose();
    vocalizationController.dispose();
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
            LabelTextField(
              initialLabel: initialLabel,
              boardId: widget.boardId,
              onDuplicateFound: (duplicatedSymbol) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF545454),
                    content: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text(
                              "Symbol o takiej nazwie już istnieje",
                              style: TextStyle(color: Colors.white),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              ref.read(symbolManagerProvider).pinSymbolsToBoard([duplicatedSymbol], boardId: widget.boardId);
                              if (!mounted) return;
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AacColors.mainControlBackground,
                              padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            child: const Text(
                              'Przypnij',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            },
                          ),
                        ],
                      ),
                    ),
                    duration: const Duration(days: 365),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    margin: const EdgeInsets.all(8),
                  ),
                );
              },
              onDuplicateResolved: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
            const SizedBox(
              height: 14,
            ),
            GenericTextField(
              controller: vocalizationController,
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
    final params = SymbolEditingParams(
        imagePath: await saveImage(imagePath),
        label: ref.read(labelProvider),
        color: ref.read(colorProvider),
        vocalization: vocalizationController.text,
        childBoard: ref.read(boardNotifierProvider));

    if (imagePath.isEmpty || !File(imagePath).existsSync()) {
      if (!mounted) return;

      showDialog(
          context: context,
          builder: (BuildContext context) =>
              Consumer(builder: (context, ref, _) {
                return NoImageSelectedDialog(
                  onDeclined: () {
                    widget.updateSymbolSettings(params);
                    Navigator.pop(context);
                  },
                  onAccepted: () => ref
                      .read(imageNotifierProvider.notifier)
                      .cherryPick(context),
                );
              }));

      return;
    }

    widget.updateSymbolSettings(params);
  }
}

class NoImageSelectedDialog extends StatelessWidget {
  const NoImageSelectedDialog(
      {super.key, required this.onAccepted, required this.onDeclined});

  final void Function() onAccepted;
  final void Function() onDeclined;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nie dodałeś obrazka"),
      content: const Text("Czy chcesz to zrobić teraz?"),
      actions: [
        TextButton(onPressed: onDeclined, child: const Text('Nie')),
        TextButton(onPressed: onAccepted, child: const Text('Tak')),
      ],
    );
  }
}

class LabelTextField extends ConsumerWidget {
  final String? initialLabel;
  final Id boardId;
  final void Function(CommunicationSymbol) onDuplicateFound;
  final void Function() onDuplicateResolved;

  const LabelTextField({
    super.key,
    required this.initialLabel,
    required this.boardId,
    required this.onDuplicateFound,
    required this.onDuplicateResolved,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(initialValuesProvider).label;
    final labelProviderNotifier = ref.read(labelProvider.notifier);
    final symbolManager = ref.read(symbolManagerProvider);

    return GenericTextField(
      labelText: "Podpis",
      initalValue: label,
      onChanged: (value) async {
        labelProviderNotifier.state = value;
        if (initialLabel != null && value == initialLabel) return;
        final duplicatedSymbol = await symbolManager.findSymbolByLabel(value);
        if (duplicatedSymbol != null) {
          onDuplicateFound(duplicatedSymbol);
        } else {
          onDuplicateResolved();
        }
      },
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
              children: [
                AppBarTextAction(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Anuluj",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                AppBarTextAction(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    submit();
                  },
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
