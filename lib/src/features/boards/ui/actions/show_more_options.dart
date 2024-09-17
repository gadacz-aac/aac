import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';

class ShowMoreOptions extends StatelessWidget {
  const ShowMoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showModalBottomSheet(
        isScrollControlled: true, 
        backgroundColor: AacColors.greyBackground,
              context: context,
              builder: (context) {
                return const BottomSheetOptions();
              },
            ),
        icon: const Icon(Icons.more_vert));
  }
}
