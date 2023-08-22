import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

const String defaultImagePath = "assets/default_image_file.png";

class SymbolSettings extends StatefulWidget {
  const SymbolSettings(
      {super.key,
      this.passedImagePath,
      this.passedSymbolName,
      this.passedIsFolder = false,
      this.passedAxisCount = 2,
      required this.updateSymbolSettings});

  final String? passedImagePath;
  final String? passedSymbolName;
  final bool passedIsFolder;
  final int passedAxisCount;
  final void Function(
          String imagePath, String symbolName, bool isFolder, int axisCount)
      updateSymbolSettings;

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
  final axisCountController = TextEditingController();
  final picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    ImageProvider image;
    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      image = FileImage(File(imagePath));
    } else {
      image = const AssetImage(defaultImagePath);
      log('imagePath is empty or file does not exist');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edytuj symbol' : 'Dodaj symbol'),
        actions: [
          IconButton(
            onPressed: () => submit(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => submit(),
        child: const Icon(Icons.save),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            FractionallySizedBox(
              widthFactor: 0.75,
              child: Image(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => pickImage(),
              child: const Text('Wybierz ikonkę'),
            ),
            const SizedBox(height: 12),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Wpisz nazwę symbolu",
                labelText: "Nazwa symbolu",
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
                value: isFolder,
                onChanged: (bool value) => {
                      setState(() {
                        isFolder = value;
                      })
                    },
                title: const Text('Czy symbol jest folderem?')),
            if (isFolder)
              TextFormField(
                controller: axisCountController,
                autocorrect: true,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Proszę wprowadzić szerokość tablicy';
                  }
                  if (int.tryParse(value)! <= 0) {
                    return 'Proszę wprowadzić liczbę większą od 0';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "2",
                  labelText: "Szerokość tablicy",
                ),
              ),
          ],
        ),
      ),
    );
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

  cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        compressQuality: 100, //? necessary? Also shouldn't it be lower?
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
                    // pop the dialog, then the page
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    pickImage(); //? opening the gallery again may be confusing for the user
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
