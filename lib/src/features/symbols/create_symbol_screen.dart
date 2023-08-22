import 'dart:developer';
import 'dart:io';

import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aac/src/features/symbols/symbol_settings.dart';

//TODO: !!! nazwy plikow sa generowane od podpisu i moga wystapic slowa o tym samym zapisie i innym znaczeniu np. zamek (moze dodac numeracje?)

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({super.key, required this.boardId});

  final Id boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  void submit(String path, String label, bool isFolder, int count) async {
    final manager = ref.read(symbolManagerProvider);

    manager.saveSymbol(
      widget.boardId,
      label: label,
      imagePath: await saveCroppedImage(path, label),
      crossAxisCount: count,
      createChild: isFolder,
    );

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<String> saveCroppedImage(String imagePath, String label) async {
    final imageFile = File(imagePath);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = transformToFileName(label);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    log('sciezka do zapisanego obrazu na urzadzeniu: $savedImage $fileName');
    return savedImage.path;
  }

  String transformToFileName(String input) {
    //add a timestamp to the file name to avoid duplicates
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final fileName = '${input.replaceAll(' ', '_')}_$timestamp.png';
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return SymbolSettings(updateSymbolSettings: submit);
  }
}
