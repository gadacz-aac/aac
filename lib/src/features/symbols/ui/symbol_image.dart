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
    if (path.startsWith("assets")) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
      );
    }
    if (Uri.parse(path).isAbsolute) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
      );
    }
    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
