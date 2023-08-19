import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:aac/src/features/symbols/ui/symbol_image.dart';

//TODO: !!! nazwy plikow sa generowane od podpisu i moga wystapic slowa o tym samym zapisie i innym znaczeniu np. zamek (moze dodac numeracje?)

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({super.key, required this.boardId});

  final Id boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  final picker = ImagePicker();
  String _imagePath = '';
  bool _isLink = false;
  late TextEditingController _controller;
  late TextEditingController _crossAxisCountController;
  final _formKey = GlobalKey<FormState>();
  String defaultImagePath = 'assets/default_image_file.png';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _crossAxisCountController = TextEditingController(text: "2");
  }

  @override
  void dispose() {
    _controller.dispose();
    _crossAxisCountController.dispose();
    super.dispose();
  }

  _imgFromGallery() async {
    bool hasPermission = await _requestPermissions();

    if (hasPermission) {
      return await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 50)
          .then((value) {
        if (value != null) {
          _cropImage(value.path);
        }
      });
    }

    log('no permission provided');
  }

  Future<bool> _requestPermissions() async {
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

  _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper()
        .cropImage(sourcePath: imagePath, aspectRatioPresets: [
      CropAspectRatioPreset.square
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor:
              const Color.fromARGB(255, 140, 9, 180), //TODO: change fixed color
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true),
      IOSUiSettings(
        title: "Image Cropper", //TODO: lockAspectRatio for IOS also!!!
      )
    ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        _imagePath = croppedFile.path;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imagePath.isNotEmpty) return _addSymbol();
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
                    _imagePath = defaultImagePath;

                    Navigator.of(context).pop();
                    _addSymbol();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  void _addSymbol() async {
    final manager = ref.read(symbolManagerProvider);

    manager.saveSymbol(
      widget.boardId,
      label: _controller.text.trim(),
      imagePath: await _saveCroppedImage(_imagePath),
      crossAxisCount: int.tryParse(_crossAxisCountController.text),
      createChild: _isLink,
    );

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<String> _saveCroppedImage(String imagePath) async {
    if (imagePath == defaultImagePath) return imagePath;

    final imageFile = File(imagePath);

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = transformToFileName(_controller.text);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    log('sciezka do zapisanego obrazu na urzadzeniu: $savedImage $fileName');
    return savedImage.path;
  }

  String transformToFileName(String input) {
    //@TODO: maybe add other letters, like é, ñ etc.
    String newFileName = input
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('ą', 'a')
        .replaceAll('ć', 'c')
        .replaceAll('ę', 'e')
        .replaceAll('ł', 'l')
        .replaceAll('ń', 'n')
        .replaceAll('ó', 'o')
        .replaceAll('ś', 's')
        .replaceAll('ź', 'z')
        .replaceAll('ż', 'z')
        .replaceAll(RegExp(r'[^a-z0-9_ ]'), '')
        .trim();

    return newFileName; //? czy powinno dodawać się jeszcze rozszerzenie .png?
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new symbol'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  final trimmedValue = value?.trim();
                  if (trimmedValue == null || trimmedValue.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Symbol's name",
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (_imagePath.isNotEmpty)
                SymbolImage(
                  _imagePath,
                  height: 300.0,
                  width: 300.0,
                ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: _imgFromGallery,
                child: const Text('Select Image'),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a number';
                  }
                  if (int.tryParse(value)! <= 0) {
                    // TODO: Można dodać obsługę tekstu, albo coś jeszcze
                    return 'The width must be higher than 0';
                  }
                  return null;
                },
                controller: _crossAxisCountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SwitchListTile(
                title: const Text('Link to a child board'),
                value: _isLink,
                onChanged: (bool value) {
                  setState(() {
                    _isLink = value;
                  });
                },
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Apply'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
