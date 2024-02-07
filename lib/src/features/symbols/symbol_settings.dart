import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/symbols/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/model/communication_color.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'ui/symbol_card.dart';

const String defaultImagePath = "assets/default_image_file.png";

class SymbolSettings extends ConsumerStatefulWidget {
  final String? passedImagePath;

  final String? passedSymbolName;
  final bool passedIsFolder;
  final int passedAxisCount;
  final int? passedSymbolColor;
  final void Function(String imagePath, String symbolName, bool isFolder,
      int axisCount, int? color) updateSymbolSettings;
  const SymbolSettings(
      {super.key,
      this.passedImagePath,
      this.passedSymbolName,
      this.passedSymbolColor,
      this.passedIsFolder = false,
      this.passedAxisCount = 2,
      required this.updateSymbolSettings});

  @override
  ConsumerState<SymbolSettings> createState() => _SymbolSettingsState();
}

class _SymbolSettingsState extends ConsumerState<SymbolSettings> {
  late String imagePath;
  late String symbolName;
  late bool isFolder;
  late int axisCount;
  int? selectedColor;

  final formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final vocalizationController = TextEditingController();
  final axisCountController = TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    imagePath = widget.passedImagePath ?? '';
    symbolName = widget.passedSymbolName ?? '';
    isFolder = widget.passedIsFolder;
    axisCount = widget.passedAxisCount;
    selectedColor = widget.passedSymbolColor;

    labelController.text = symbolName;
    axisCountController.text = axisCount.toString();

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
            ColorPicker(value: selectedColor, onChange: handleColorChange)
            // SwitchListTile(
            //     value: isFolder,
            //     onChanged: (bool value) => {
            //           setState(() {
            //             isFolder = value;
            //           })
            //         },
            //     title: const Text('Czy symbol jest folderem?')),
            // if (isFolder)
            //   TextFormField(
            //     controller: axisCountController,
            //     autocorrect: true,
            //     keyboardType: TextInputType.number,
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Proszę wprowadzić szerokość tablicy';
            //       }
            //       if (int.tryParse(value)! <= 0) {
            //         return 'Proszę wprowadzić liczbę większą od 0';
            //       }
            //       return null;
            //     },
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: "2",
            //       labelText: "Szerokość tablicy",
            //     ),
            //   ),
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

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    symbolName = labelController.text;
    axisCount = int.parse(axisCountController.text);
    int? color = selectedColor;

    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      widget.updateSymbolSettings(
          imagePath, symbolName, isFolder, axisCount, color);
    } else {
      log('dialog');
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
                    widget.updateSymbolSettings(defaultImagePath, symbolName,
                        isFolder, axisCount, color);
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
