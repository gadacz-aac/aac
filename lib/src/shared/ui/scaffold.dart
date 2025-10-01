import 'package:flutter/material.dart';

class AacScaffold extends StatelessWidget {
  const AacScaffold(
      {super.key, this.appBar, this.floatingActionButton, required this.body});

  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(child: body),
    );
  }
}
