import 'package:flutter/material.dart';

class BottomSheetOptions extends StatelessWidget {
  final List<Widget> children;

  const BottomSheetOptions({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            26, 26, 26, MediaQuery.of(context).padding.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}
