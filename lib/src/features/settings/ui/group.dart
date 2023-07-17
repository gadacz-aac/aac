import 'package:flutter/material.dart';

class PersistentGroup extends StatelessWidget {
  const PersistentGroup({
    Key? key,
    this.title,
    this.isFirst = false,
    required this.children,
  }) : super(key: key);

  final Widget? title;
  final List<Widget> children;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
    return Column(
      children: [
        if (!isFirst) const Divider(),
        if (title != null)
          ListTile(
              title: DefaultTextStyle(style: titleTextStyle!, child: title!)),
        ...children,
      ],
    );
  }
}
