import 'package:aac/src/features/main_menu/overview_screen.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentSymbols extends ConsumerWidget {
  const RecentSymbols({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbols = ref.watch(recentlyEditedSymbolsProvider).valueOrNull;
    if (symbols == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: symbols
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            SizedBox(width: 140, child: SymbolCard(symbol: e)),
                      ))
                  .toList())),
    );
  }
}
