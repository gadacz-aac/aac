import 'dart:io';

import 'package:flutter/material.dart';

class SymbolImage extends StatelessWidget {
  const SymbolImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Uri.parse(path).isAbsolute
        ? Image.network(
            path,
            width: width,
            height: height,
            fit: fit,
          )
        : Image.file(
            File(path),
            width: width,
            height: height,
            fit: fit,
          );
  }
}
