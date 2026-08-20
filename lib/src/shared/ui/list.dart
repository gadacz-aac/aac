import 'package:aac/src/shared/colors.dart' show AacColors;
import 'package:flutter/material.dart';

class AacList extends ListView {
  AacList.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required NullableIndexedWidgetBuilder itemBuilder,
    super.findChildIndexCallback,
    required super.itemCount,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.hitTestBehavior,
  }) : super.builder(itemBuilder: (context, index) {
          final child = itemBuilder(context, index);

          if (child == null) {
            return null;
          }

          BorderRadiusGeometry? radiusGeometry;
          if (index == 0) {
            radiusGeometry = BorderRadiusGeometry.directional(
              topStart: Radius.circular(12),
              topEnd: Radius.circular(12),
            );
          } else if (itemCount != null && index == itemCount - 1) {
            radiusGeometry = BorderRadiusGeometry.directional(
              bottomStart: Radius.circular(12),
              bottomEnd: Radius.circular(12),
            );
          }

          // Material is nessecery to apply borderRadius
          return Material(
              child: Theme(
                  data: Theme.of(context).copyWith(
                    listTileTheme: ListTileTheme.of(context).copyWith(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: AacColors.fineBorder),
                            borderRadius:
                                radiusGeometry ?? BorderRadiusGeometry.zero)),
                  ),
                  child: child));
        });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          listTileTheme: ListTileTheme.of(context).copyWith(
        tileColor: Colors.white,
      )),
      child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(12),
          clipBehavior: Clip.hardEdge,
          child: super.build(context)),
    );
  }
}
