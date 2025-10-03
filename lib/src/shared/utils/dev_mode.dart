import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDevModeProvider = StateProvider((_) => kDebugMode);

void showDevModeToggleDialog(BuildContext context, WidgetRef ref) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: GenericTextField(
              labelText: ":3",
              onChanged: (val) {
                if (val == "dupa") {
                  ref.read(isDevModeProvider.notifier).state = true;
                }
              },
            ),
          ),
        );
      });
}
