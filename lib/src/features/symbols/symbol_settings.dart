import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/file_helpers.dart';
import 'package:aac/src/features/symbols/model/communication_color.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';

import '../../shared/isar_provider.dart';
import 'ui/symbol_card.dart';

const String defaultImagePath = "assets/default_image_file.png";

class SymbolSettings extends ConsumerStatefulWidget {
  final SymbolEditingParams? params;
  // the params here should be at least it's own type
  final void Function(SymbolEditingParams) updateSymbolSettings;
  const SymbolSettings(
      {super.key, this.params, required this.updateSymbolSettings});

  @override
  ConsumerState<SymbolSettings> createState() => _SymbolSettingsState();
}

class _SymbolSettingsState extends ConsumerState<SymbolSettings> {
  late String imagePath;
  late String symbolName;
  int? selectedColor;

  final formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final vocalizationController = TextEditingController();
  final axisCountController = TextEditingController();
  final picker = ImagePicker();

  Board? childBoard;

  @override
  void initState() {
    imagePath = widget.params?.imagePath ?? '';
    symbolName = widget.params?.label ?? '';
    selectedColor = widget.params?.color;
    childBoard = widget.params?.childBoard;

    labelController.text = symbolName;
    super.initState();
  }

  @override
  void dispose() {
    labelController.dispose();
    axisCountController.dispose();
    vocalizationController.dispose();

    super.dispose();
  }

  void handleColorChange(int? colorCode) {
    setState(() {
      selectedColor = colorCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    String image;
    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      image = imagePath;
    } else {
      image = defaultImagePath;
      log('imagePath is empty or file does not exist');
    }

    return Scaffold(
      appBar: AppBar(
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
                    onTap: submit,
                    child: const Text(
                      "Zapisz",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ]),
          )),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(height: 28),
            FractionallySizedBox(
              widthFactor: 0.55,
              child: Stack(children: [
                SymbolCard(
                    symbol: CommunicationSymbol(
                        label: labelController.text,
                        imagePath: image,
                        color: selectedColor)),
                Positioned(
                    top: 6,
                    right: 3,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 25.0),
                                child: Wrap(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ImageCherryPicker()))
                                            .then((value) {
                                          setState(() {
                                            imagePath = value;
                                          });
                                          Navigator.pop(context);
                                        });
                                      },
                                      leading: const Icon(Icons.edit_outlined),
                                      title: const Text("Zamień Obraz"),
                                    ),
                                    ListTile(
                                      enabled: image != defaultImagePath,
                                      onTap: () {
                                        cropImage(imagePath);
                                        Navigator.pop(context);
                                      },
                                      leading: const Icon(Icons.crop_outlined),
                                      title: const Text("Przytnij Obraz"),
                                    ),
                                    ListTile(
                                      enabled: image != defaultImagePath,
                                      onTap: () {
                                        deleteImage();
                                        Navigator.pop(context);
                                      },
                                      leading:
                                          const Icon(Icons.delete_outlined),
                                      title: const Text("Usuń Obraz"),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: const BoxDecoration(
                              color: Color(0xFF545454),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: const Text(
                            "Edytuj",
                            style: TextStyle(height: 2, color: Colors.white),
                          )),
                    ))
              ]),
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: labelController,
              autocorrect: true,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Proszę wprowadzić nazwę symbolu';
                }
                return null;
              },
              onChanged: (_) {
                /* TODO idk about this. it just seems far
                from ideal but it works for now, i guess */
                setState(() {});
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Podpis",
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextFormField(
              controller: vocalizationController,
              autocorrect: true,
              keyboardType: TextInputType.text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Wokalizacja (opcjonalnie)",
                  helperText: "Co powiedzieć po naciśnięciu"),
            ),
            const SizedBox(
              height: 14.0,
            ),
            ColorPicker(value: selectedColor, onChange: handleColorChange),
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

  cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        compressQuality: 60, //? isn't it too low?
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: [
          CropAspectRatioPreset.square
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Przycinanie zdjęcia",
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            title:
                "Przycinanie zdjęcia", //TODO: lockAspectRatio for IOS also!!!
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      log('image cropped, path: ${croppedFile.path}');
      setState(() {
        imagePath = croppedFile.path;
      });
    }
  }

  void deleteImage() {
    setState(() {
      imagePath = defaultImagePath;
    });
  }

  void submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final params = SymbolEditingParams(
        imagePath: await saveImage(imagePath),
        label: labelController.text,
        color: selectedColor);

    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      widget.updateSymbolSettings(params);
      return;
    }

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please Confirm'),
          content: const Text(
              "You didn't choose a symbol. Would you like to use the default symbol?"),
          actions: [
            TextButton(
                onPressed: () {
                  widget.updateSymbolSettings(params);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  final path = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImageCherryPicker()));
                  setState(() {
                    imagePath = path;
                  });
                },
                child: const Text('No'))
          ],
        );
      },
    );
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

final colors = [
  CommunicationColor(label: "Rzeczownik", code: 0xFFFBAF3C),
  CommunicationColor(label: "Przymiotnik", code: 0xFF66C4FB),
  CommunicationColor(label: "Czasownik", code: 0xFF9ADF7D),
  CommunicationColor(label: "Barbie", code: 0xFFFB88CF),
  CommunicationColor(label: "Lucy", code: 0xFFFB4C4C),
];

class ColorPicker extends ConsumerWidget {
  const ColorPicker({super.key, required this.value, required this.onChange});

  final int? value;
  final void Function(int?) onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: colors
                .expand((e) => [
                      ColorChip(
                        color: e,
                        onChange: onChange,
                        selectedColor: value,
                      ),
                      const SizedBox(
                        width: 11,
                      )
                    ])
                .toList()));
  }
}

class ColorChip extends ConsumerWidget {
  const ColorChip(
      {super.key,
      required this.color,
      required this.selectedColor,
      required this.onChange});

  final CommunicationColor color;
  final int? selectedColor;
  final void Function(int?) onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = selectedColor == color.code;
    return ChoiceChip(
        avatar: CircleAvatar(backgroundColor: Color(color.code)),
        selectedColor: const Color(0xFFF7F2F9),
        showCheckmark: false,
        label: Text(color.label),
        selected: isSelected,
        onSelected: (_) {
          onChange(color.code);
        });
  }
}

class BoardPicker extends StatelessWidget {
  const BoardPicker(
      {super.key,
      required this.childBoard,
      required this.onCancel,
      required this.setChildBoard});

  final Board? childBoard;
  final void Function(Board?) setChildBoard;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> chips;

    if (childBoard == null) {
      chips = [
        LinkNewBoardChip(setChildBoard: setChildBoard),
        LinkExistingBoardChip(
            childBoard: childBoard, setChildBoard: setChildBoard)
      ];
    } else {
      chips = [
        InputChip(
          label: Text("${childBoard?.name}"),
          onDeleted: onCancel,
        )
      ];
    }

    return Row(
      children: chips
          .expand((element) => [
                element,
                const SizedBox(
                  width: 11,
                )
              ])
          .toList(),
    );
  }
}

final crossAxisCountProvider = StateProvider((ref) => 2.0);

class LinkNewBoardChip extends StatelessWidget {
  const LinkNewBoardChip({super.key, required this.setChildBoard});

  final void Function(Board?) setChildBoard;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<Board?>(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => const CreateBoardScreen())
            .then(setChildBoard);
      },
      label: const Text("Dodaj nową"),
    );
  }
}

class CreateBoardScreen extends ConsumerWidget {
  const CreateBoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crossAxisCount = ref.watch(crossAxisCountProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 27.0),
      child: Column(children: [
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Podpis",
          ),
        ),
        ListTile(
          title: const Text("Szerokość"),
          subtitle: Slider(
              min: 2,
              max: 8,
              value: crossAxisCount,
              onChanged: (v) {
                ref.read(crossAxisCountProvider.notifier).update((state) => v);
              }),
        )
      ]),
    );
  }
}

class LinkExistingBoardChip extends StatelessWidget {
  const LinkExistingBoardChip({
    super.key,
    required this.setChildBoard,
    required this.childBoard,
  });

  final Board? childBoard;
  final void Function(Board?) setChildBoard;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
        avatar: const Icon(Icons.search_outlined),
        onPressed: () {
          showModalBottomSheet<Board?>(
              backgroundColor: Colors.white,
              context: context,
              isDismissible: true,
              builder: (context) => const BoardSearch()).then(setChildBoard);
        },
        label: const Text("Wyszukaj istniejącą"));
  }
}

final foundBoards = FutureProvider.autoDispose<List<Board>>((ref) async {
  final isar = ref.watch(isarProvider);
  final query = ref.watch(queryProvider);

  return isar.boards.where().wordsElementStartsWith(query).findAll();
});

class BoardSearch extends ConsumerWidget {
  const BoardSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(foundBoards).valueOrNull;
    final query = ref.watch(queryProvider);
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 27.0),
      child: Column(
        children: [
          AacTextField(
            icon: const Icon(Icons.search),
            placeholder: "Szukaj w tablicach",
            onChanged: (value) {
              final debounce = Debouncer(const Duration(milliseconds: 300));
              debounce(() =>
                  ref.read(queryProvider.notifier).update((state) => value));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          results == null || results.isEmpty
              ? Text(
                  "Hmm.. nie znaleźliśmy wyników dla \"$query\"",
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final board = results[index];
                    return ListTile(
                      onTap: () => Navigator.pop(context, board),
                      title: Text(
                        board.name,
                      ),
                    );
                  },
                ))
        ],
      ),
    );
  }
}
