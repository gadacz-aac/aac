import 'package:flutter/material.dart';

class OverviewSectionTitle extends StatelessWidget {
  const OverviewSectionTitle(this.text, {super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
