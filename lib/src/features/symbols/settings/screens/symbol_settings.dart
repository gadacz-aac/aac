import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/settings/utils/file_helpers.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/settings/widgets/board_picker.dart';
import 'package:aac/src/features/symbols/settings/widgets/color_picker.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../ui/symbol_card.dart';

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
            GenericTextField(
              name: "label",
              labelText: "Podpis",
              initalValue: widget.params?.label,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Proszę wprowadzić nazwę symbolu';
                }
                return null;
              },
            ),
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
