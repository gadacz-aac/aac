import 'package:aac/src/features/symbols/model/communication_color.dart';
import 'package:aac/src/features/symbols/settings/screens/symbol_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO Move to constants

final colors = [
  CommunicationColor(label: "Rzeczownik", code: 0xFFFBAF3C),
  CommunicationColor(label: "Przymiotnik", code: 0xFF66C4FB),
  CommunicationColor(label: "Czasownik", code: 0xFF9ADF7D),
  CommunicationColor(label: "Barbie", code: 0xFFFB88CF),
  CommunicationColor(label: "Lucy", code: 0xFFFB4C4C),
];

final colorProvider = StateProvider(
    (ref) => ref.watch(initalValuesProvider)?.color,
    dependencies: [initalValuesProvider]);

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
        label: Text(color.label),
        selected: isSelected,
        onSelected: (_) {
          ref.read(colorProvider.notifier).state = color.code;
        });
  }
}
