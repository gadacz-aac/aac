import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/symbols/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

//@TODO: Słowa o tym samym zapisie i innym znaczeniu

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({super.key, required this.boardId});

  final Id boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  
  final picker = ImagePicker();
  String _imagePath = '';
  File? imageFile;
  bool _isLink = false;
  late TextEditingController _controller;
  late TextEditingController _crossAxisCountController;
  final _formKey = GlobalKey<FormState>();
  // String defaultImagePath = '/assets/default_image_file.png'; //nie dziala bo ma problem z manager.saveSymbol i kloci sie z imageproviderem
  String defaultImagePath = "https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png";


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


//moze przyda sie w przyszlosci
Future<File> getFileFromAsset(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final buffer = byteData.buffer.asUint8List();
  final tempDir = Directory.systemTemp;
  final tempFilePath = '${tempDir.path}/$assetPath';
  final tempFile = File(tempFilePath);
  tempFile.writeAsBytesSync(buffer);
  return tempFile;
}

  _imgFromGallery() async {
    await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: const Color.fromARGB(255, 140, 9, 180), //TODO: change fixed color
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true
            ),
          IOSUiSettings(
            title: "Image Cropper", //TODO: lockAspectRatio for IOS also!!!
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      // Use croppedFile.path as the imagePath
      if (imageFile?.path == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Please Confirm'),
              content: const Text("You didn't choose a symbol. Would you like to use the default symbol?"),
              actions: [
                TextButton(
                    onPressed: () {
                      // imageFile = await getFileFromAsset(defaultImagePath); //nie dziala
                      // _imagePath = imageFile!.path;
                      _imagePath = defaultImagePath;
                      // _imagePath = defaultImagePath;
                      // imageFile = File(_imagePath); //nie jest potrzebne bo warunki

                      Navigator.of(context).pop();  //close the dialog
                      _addSymbol();
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();  //close the dialog
                    },
                    child: const Text('No'))
              ],
            );
          }
        );
      } else {
        _imagePath = imageFile!.path;
        _addSymbol();
      }
    }
  }

  void _addSymbol(){
    final manager = ref.read(symbolManagerProvider);

    manager.saveSymbol(
      widget.boardId,
      label: _controller.text.trim(),
      imagePath: _imagePath,
      crossAxisCount: _crossAxisCountController.text,
      createChild: _isLink,
    );
    
    if (_imagePath != defaultImagePath){
      _saveCroppedImage(imageFile!);
    }
    
    if (context.mounted){
      Navigator.pop(context);
    }
  }

  Future<void> _saveCroppedImage(File imageFile) async {
    if (imageFile.path != defaultImagePath) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = transformToFileName(_controller.text);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      log('sciezka do zapisanego obrazu na urzadzeniu: $savedImage $fileName');    // savedImage zawiera ścieżkę do zapisanego obrazu na urządzeniu
    }
  }

  String transformToFileName(String input) {//@TODO: maybe add other letters, like é, ñ etc.
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

    return newFileName; //@TODO czy powinno dodawać się jeszcze rozszerzenie .png?
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
            // Image.asset("assets/default_image_file.png"), //wyswietlanie pliku z assets
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
                hintText: "Enter Symbol's name", // Pass it in Navigator.pop
              ),
            ),
            
            const SizedBox(height: 20.0,),
            if (imageFile != null) // Show the cropped image
            Image.file(//@TODO: SymbolImage()
              imageFile!,
              height: 300.0,
              width: 300.0,
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage,
                ].request();
                if(statuses[Permission.storage]!.isGranted){
                  _imgFromGallery();
                } else {
                  log('no permission provided');
                }
              },
              child: const Text('Select Image'),
            ),
            TextFormField(
              validator: (value) {//@TODO: może  zabronić używania spacji na końcu nazwy?
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
      )
    );
  }
}