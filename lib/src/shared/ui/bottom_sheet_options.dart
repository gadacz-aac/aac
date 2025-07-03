import 'package:flutter/material.dart';

class BottomSheetOptions extends StatelessWidget {
  final List<Widget> children;

  const BottomSheetOptions({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}
