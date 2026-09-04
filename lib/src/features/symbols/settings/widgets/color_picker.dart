import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/model/communication_color.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/experimental/scope.dart';

@Dependencies([initialValues])
final colorProvider = StateProvider.autoDispose(
    (ref) => ref.watch(initialValuesProvider).color,
    dependencies: [initialValuesProvider]);

class ColorPicker extends ConsumerWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: colors
                .expand((e) => [
                      ColorChip(
                        color: e,
                      ),
                      const SizedBox(
                        width: 11,
                      )
                    ])
                .toList()));
  }
}

class ColorChip extends ConsumerWidget {
  const ColorChip({
    super.key,
    required this.color,
  });

  final CommunicationColor color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(colorProvider) == color.code;
    return ChoiceChip(
        avatar: CircleAvatar(backgroundColor: Color(color.code)),
        selectedColor: const Color(0xFFF7F2F9),
        showCheckmark: false,
        label: Text(
            localizedColorLabel(AppLocalizations.of(context), color)),
        selected: isSelected,
        onSelected: (selected) {
          // tapping a selected chip unselects the color
          ref.read(colorProvider.notifier).state = selected ? color.code : null;
        });
  }
}
