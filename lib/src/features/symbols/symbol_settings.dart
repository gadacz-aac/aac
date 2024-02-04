import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/symbols/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ui/symbol_card.dart';

const String defaultImagePath = "assets/default_image_file.png";

class SymbolSettings extends StatefulWidget {
  final String? passedImagePath;

  final String? passedSymbolName;
  final bool passedIsFolder;
  final int passedAxisCount;
  final void Function(
          String imagePath, String symbolName, bool isFolder, int axisCount)
      updateSymbolSettings;
  const SymbolSettings(
      {super.key,
      this.passedImagePath,
      this.passedSymbolName,
      this.passedIsFolder = false,
      this.passedAxisCount = 2,
      required this.updateSymbolSettings});

  @override
  State<SymbolSettings> createState() => _SymbolSettingsState();
}

class _SymbolSettingsState extends State<SymbolSettings> {
  late String imagePath;
  late String symbolName;
  late bool isFolder;
  late int axisCount;
  bool isEditing = false;

  final formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final vocalizationController = TextEditingController();
  final axisCountController = TextEditingController();
  final picker = ImagePicker();

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
                        label: labelController.text, imagePath: image)),
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
                                    const ListTile(
                                      leading: Icon(Icons.crop_outlined),
                                      title: Text("Przytnij Obraz"),
                                    ),
                                    ListTile(
                                      onTap: deleteImage,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // TODO you can't actually select any of this, this chip really should be another component
                  ChoiceChip(
                      avatar: const CircleAvatar(
                        backgroundColor: AacColors.nounOrange,
                      ),
                      selectedColor: const Color(0xFFF7F2F9),
                      showCheckmark: false,
                      label: const Text("Rzeczownik"),
                      selected: true,
                      onSelected: (_) {}),
                  const SizedBox(
                    width: 11,
                  ),
                  ChoiceChip(
                      avatar: const CircleAvatar(
                          backgroundColor: AacColors.verbGreen),
                      selectedColor: const Color(0xFFF7F2F9),
                      showCheckmark: false,
                      label: const Text("Czasownik"),
                      selected: false,
                      onSelected: (_) {}),
                  const SizedBox(
                    width: 11,
                  ),
                  ChoiceChip(
                      avatar: const CircleAvatar(
                          backgroundColor: AacColors.adjectiveBlue),
                      selectedColor: const Color(0xFFF7F2F9),
                      showCheckmark: false,
                      label: const Text("Przymiotnik"),
                      selected: false,
                      onSelected: (_) {}),
                  const SizedBox(
                    width: 11,
                  ),
                  ChoiceChip(
                      avatar: const CircleAvatar(
                          backgroundColor: AacColors.prepositionPink),
                      selectedColor: const Color(0xFFF7F2F9),
                      showCheckmark: false,
                      label: const Text("Barbie"),
                      selected: false,
                      onSelected: (_) {})
                ],
              ),
            )
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

  @override
  void dispose() {
    labelController.dispose();
    axisCountController.dispose();
    vocalizationController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    imagePath = widget.passedImagePath ?? '';
    symbolName = widget.passedSymbolName ?? '';
    isFolder = widget.passedIsFolder;
    axisCount = widget.passedAxisCount;

    labelController.text = symbolName;
    axisCountController.text = axisCount.toString();

    if (widget.passedImagePath != null) {
      isEditing = true;
    }

    super.initState();
  }

  pickImage() async {
    bool hasPermission = await requestPermissions();

    if (hasPermission) {
      return await ImagePicker()
          .pickImage(source: ImageSource.gallery)
          .then((value) {
        if (value != null) {
          cropImage(value.path);
        }
      });
    }
    log('no permission provided');
  }

  Future<bool> requestPermissions() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> statuses;

    if (androidInfo.version.sdkInt <= 32) {
      statuses = await [Permission.storage].request();
    } else {
      statuses = await [Permission.photos].request();
    }

    return statuses.values
        .every((status) => status == PermissionStatus.granted);
  }

  void submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    symbolName = labelController.text;
    axisCount = int.parse(axisCountController.text);

    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      widget.updateSymbolSettings(imagePath, symbolName, isFolder, axisCount);
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
                    widget.updateSymbolSettings(
                        defaultImagePath, symbolName, isFolder, axisCount);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    pickImage();
                    return;
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
