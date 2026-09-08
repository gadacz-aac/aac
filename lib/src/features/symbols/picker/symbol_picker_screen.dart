import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/shared/ui/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Focused screen for choosing existing symbols to add to a board. Unlike the
/// search screen it offers no admin options, only selection; pops with the
/// list of selected symbols.
class SymbolPickerScreen extends ConsumerWidget {
  const SymbolPickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          ref.read(selectedSymbolsProvider).clear();
        }
      },
      child: AacScaffold(
        appBar: AppBar(
          title: Text(l10n.addExistingSymbol),
          actions: const [ConfirmPickerAction()],
        ),
        body: ProviderScope(
          overrides: [searchedSymbolProvider, localQueryProvider],
          child: const SymbolPickerBody(),
        ),
      ),
    );
  }
}

class SymbolPickerBody extends ConsumerWidget {
  const SymbolPickerBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SearchScreen(
      asyncValue: ref.watch(searchedSymbolProvider),
      what: l10n.symbolsGenitive,
      onChanged: (val) {
        ref.read(localQueryProvider.notifier).state = val;
      },
      resultBuilder: (results) => AlignedGridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: const EdgeInsets.all(8.0),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final e = results[index];

            return SymbolCard(
              symbol: e,
              onTapActions: [SymbolSelectAction()],
            );
          }),
    );
  }
}

class ConfirmPickerAction extends ConsumerWidget {
  const ConfirmPickerAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        // mutable state is the real devil, and i called them crazy
        final selectedSymbols = [...ref.read(selectedSymbolsProvider).state];
        ref.read(selectedSymbolsProvider.notifier).clear();
        Navigator.pop(context, selectedSymbols);
      },
      icon: const Icon(Icons.check),
    );
  }
}
