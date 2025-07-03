import 'package:aac/src/shared/padding.dart';
import 'package:flutter/material.dart';

class AacList extends StatelessWidget {
  final AacListTile? Function(BuildContext, int) itemBuilder;

  final int itemCount;

  const AacList(
      {super.key, required this.itemBuilder, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AacPaddings.horizontal16,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ));
  }
}

class AacListTile extends StatelessWidget {
  final Widget title;

  final Widget subtitle;

  final bool isLast;

  final bool isFirst;

  final Widget? trailing;

  final Function()? onTap;

  const AacListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isLast,
      required this.isFirst,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(width: 1, color: const Color(0xFFE9E9E9));

    final radius = Radius.circular(5);

    final BorderRadiusGeometry? borderRadius;

    if (isFirst) {
      borderRadius = BorderRadius.only(topLeft: radius, topRight: radius);
    } else if (isLast) {
      borderRadius = BorderRadius.only(bottomLeft: radius, bottomRight: radius);
    } else {
      borderRadius = null;
    }

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
            border: Border(
                left: border,
                top: border,
                right: border,
                bottom: isLast ? border : BorderSide.none)),
        child: ListTile(
          title: title,
          onTap: onTap,
          subtitle: subtitle,
          trailing: trailing,
        ));
  }
}
