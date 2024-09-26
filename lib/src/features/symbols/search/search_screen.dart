import 'package:aac/src/features/boards/ui/actions/move_symbol_to_bin_action.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/settings/widgets/cherry_pick_image.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/utils/debounce.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/search/search_app_bar.dart';
import 'package:aac/src/features/symbols/search/symbol_search_filters.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final searchedSymbolProvider =
    FutureProvider.autoDispose<List<CommunicationSymbol>>((ref) async {
  final isar = ref.watch(isarProvider);
  final query = ref.watch(queryProvider);
  final color = ref.watch(symbolSearchColorFilterProvider)?.code;
  final onlyPinned = ref.watch(symbolSearchOnlyPinnedFilterProvider);

  return isar.communicationSymbols
      .where()
      .wordsElementStartsWith(query)
      .filter()
      .isDeletedEqualTo(false)
      .optional(color != null, (q) => q.colorEqualTo(color))
      .optional(onlyPinned, (q) => q.parentBoardIsEmpty())
      .findAll();
});

final queryProvider = StateProvider.autoDispose<String>((ref) => "");

class SelectedSymbolNotifier extends ChangeNotifier {
  final state = <CommunicationSymbol>[];

  void toggle(CommunicationSymbol symbol) {
    final index = state.indexWhere((e) => e.id == symbol.id);
    if (index == -1) {
      state.add(symbol);
    } else {
      state.removeWhere((element) => element.id == symbol.id);
    }
    notifyListeners();
  }

  void clear() {
    state.clear();
    notifyListeners();
  }
}

final selectedSymbolsProvider =
    ChangeNotifierProvider<SelectedSymbolNotifier>((ref) {
  return SelectedSymbolNotifier();
});

final areMultipleSymbolsSelected = Provider<bool>((ref) {
  final selected = ref.watch(selectedSymbolsProvider);
  return selected.state.length > 1;
});

final areSymbolsSelectedProvider = Provider<bool>((ref) {
  final selected = ref.watch(selectedSymbolsProvider);
  return selected.state.isNotEmpty;
});

class SymbolSearchScreen extends ConsumerWidget {
  const SymbolSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchedSymbolProvider).valueOrNull;
    final hasResults = results != null && results.isNotEmpty;

    final theme = Theme.of(context);
    final appBarTheme = theme.copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: theme.colorScheme.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        backgroundColor: theme.colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        titleTextStyle: theme.textTheme.titleLarge,
        toolbarTextStyle: theme.textTheme.bodyMedium,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: theme.inputDecorationTheme.hintStyle,
        border: InputBorder.none,
      ),
    );

    return Theme(
        data: appBarTheme,
        child: PopScope(
            onPopInvoked: (didPop) {
              if (didPop) {
                ref.read(selectedSymbolsProvider).clear();
              }
            },
            child: Scaffold(
                appBar: const SearchAppBar(),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SearchFilters(),
                    ),
                    if (!hasResults)
                      const NoResultsScreen()
                    else
                      Expanded(
                        child: AlignedGridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            padding: const EdgeInsets.all(8.0),
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              final e = results[index];
                              return SymbolCard(
                                symbol: e,
                                onTapActions: const [SymbolOnTapAction.select],
                              );
                            }),
                      ),
                  ],
                ))));
  }
}

class NoResultsScreen extends ConsumerWidget {
  const NoResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(queryProvider);
    final isLoading = ref.watch(searchedSymbolProvider).isLoading;
    final textTheme = Theme.of(context).textTheme;
    if (search.isEmpty || isLoading) return const SizedBox();
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Image.asset(
                  'assets/could-not-find-anything-symbol-arrasac.png',
                  width: 100,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  "Hmm.. nie znaleźliśmy wyników dla \"$search\"",
                  style: textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Spróbuj innego zapytania albo zmień filtry",
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
