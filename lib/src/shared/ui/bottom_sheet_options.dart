import 'package:flutter/material.dart';

class BottomSheetOptions extends StatelessWidget {
  final List<Widget> children;

  const BottomSheetOptions(
      {super.key,
      required this.children,
      this.useSingleChildScrollView = true});

  final bool useSingleChildScrollView;

  @override
  Widget build(BuildContext context) {
    var child = Padding(
      padding: EdgeInsets.fromLTRB(
          26, 26, 26, MediaQuery.of(context).padding.bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );

    if (useSingleChildScrollView) {
      return SingleChildScrollView(
        child: child,
      );
    }

    return child;
  }
}
