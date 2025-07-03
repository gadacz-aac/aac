import 'package:flutter/material.dart';

class PersistentGroup extends StatelessWidget {
  const PersistentGroup({
    super.key,
    this.title,
    this.subtitle,
    this.isFirst = false,
    required this.children,
  });

  final Widget? title;
  final Widget? subtitle;
  final List<Widget> children;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirst) const Divider(),
        if (title != null)
          ListTile(
              subtitle: subtitle,
              title: DefaultTextStyle(
                style: titleTextStyle!,
                child: title!,
              )),
        ...children,
      ],
    );
  }
}
