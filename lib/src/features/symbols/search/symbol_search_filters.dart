import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/model/communication_color.dart';
import 'package:aac/src/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final symbolSearchColorFilterProvider =
    StateProvider.autoDispose<CommunicationColor?>((ref) {
  return null;
});

final symbolSearchOnlyPinnedFilterProvider =
    StateProvider.autoDispose<bool>((ref) {
  return false;
});

class SearchFilters extends StatelessWidget {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: const [
        SymbolSearchColorFilterChip(),
        SizedBox(
          width: 8.0,
        ),
        SymbolSearchPinnedFilterChip()
      ]),
    );
  }
}

class SymbolSearchPinnedFilterChip extends ConsumerWidget {
  const SymbolSearchPinnedFilterChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChoiceChip(
      label: Text(AppLocalizations.of(context).unpinnedChip),
      selected: ref.watch(symbolSearchOnlyPinnedFilterProvider),
      onSelected: (_) => ref
          .read(symbolSearchOnlyPinnedFilterProvider.notifier)
          .update((prev) => !prev),
    );
  }
}

class SymbolSearchColorFilterChip extends ConsumerWidget {
  const SymbolSearchColorFilterChip({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final color = ref.watch(symbolSearchColorFilterProvider);
    return ActionChip(
        avatar: color != null
            ? CircleAvatar(radius: 9, backgroundColor: Color(color.code))
            : null,
        label: Row(
          children: [
            Text(color != null
                ? localizedColorLabel(l10n, color)
                : l10n.colorChip),
            const SizedBox(
              width: 8.0,
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 18.0,
            )
          ],
        ),
        labelPadding: const EdgeInsets.only(left: 8.0),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: AacColors.greyBackground,
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: SingleChildScrollView(
                        child: RadioGroup(
                          groupValue:
                              ref.watch(symbolSearchColorFilterProvider)?.code,
                          onChanged: (val) {
                            ref
                                    .read(symbolSearchColorFilterProvider.notifier)
                                    .state =
                                colors.where((e) => e.code == val).firstOrNull;

                            Navigator.pop(context);
                          },
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: colors
                                  .map((e) => RadioListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        title: Row(children: [
                                          CircleAvatar(
                                              radius: 9,
                                              backgroundColor: Color(e.code)),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(localizedColorLabel(l10n, e)),
                                        ]),
                                        value: e.code,
                                        toggleable: true,
                                      ))
                                  .toList()),
                        ),
                      )),
                );
              });
        });
  }
}
