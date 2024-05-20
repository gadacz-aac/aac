import 'dart:developer';

import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_provider.g.dart';

@Riverpod(dependencies: [initialValues])
class ImageNotifier extends _$ImageNotifier {
  @override
  String build() {
    final initialImage = ref.watch(initialValuesProvider).imagePath;
    final defaultImage = ref.watch(defaultImagePathProvider);
    return initialImage ?? defaultImage;
  }

  cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: state,
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

    if (croppedFile == null) return;
    // imageCache.clear(); // TODO co to?
    log('image cropped, path: ${croppedFile.path}');
    state = croppedFile.path;
  }

  Future<void> cherryPick(BuildContext context,
      {bool pushReplacement = true}) async {
    if (!context.mounted) return;

    final open = pushReplacement ? Navigator.pushReplacement : Navigator.push;

    state = await open(context,
        MaterialPageRoute(builder: (context) => const ImageCherryPicker()));
  }

  void deleteImage() {
    state = ref.read(defaultImagePathProvider);
  }
}

@Riverpod(dependencies: [ImageNotifier])
bool isDefaultImage(IsDefaultImageRef ref) {
  return ref.watch(defaultImagePathProvider) ==
      ref.watch(imageNotifierProvider);
}
