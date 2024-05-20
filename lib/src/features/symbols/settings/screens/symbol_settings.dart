import 'package:aac/src/features/boards/model/board.dart';
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
  Board? childBoard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SymbolSettingsAppBar(),
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
            const GenericTextField(
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
            BoardPicker(
              childBoard: childBoard,
              setChildBoard: (board) {
                if (board == null) return;
                setState(() {
                  childBoard = board;
                });
              },
              onCancel: () {
                setState(() {
                  childBoard = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // const params = SymbolEditingParams();
    // final params = SymbolEditingParams(
    //     imagePath: await saveImage(imagePath),
    //     label: labelController.text,
    //     color: null);

    // if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
    //   widget.updateSymbolSettings(params);
    //   return;
    // }

    if (!mounted) return;
    showDialog(
        context: context,
        builder: (BuildContext context) => const NoImageSelectedDialog());
  }
}

class NoImageSelectedDialog extends StatelessWidget {
  const NoImageSelectedDialog({super.key});

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
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // final path = await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ImageCherryPicker()));
              // setState(() {
              //   imagePath = path;
              // }); // TODO dupa
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
  const SymbolSettingsAppBar({super.key});

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
                  child: const Text(
                    "Anuluj",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                AppBarTextAction(
                  onTap: () {}, // TODO dupa,
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
