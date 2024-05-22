import 'package:aac/src/features/boards/ui/actions/delete_forever_action.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_card.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:aac/src/shared/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:isar/isar.dart';

import 'app_bar_actions.dart';

final searchedSymbolProvider =
    FutureProvider.autoDispose<List<CommunicationSymbol>>((ref) async {
  final isar = ref.watch(isarProvider);
  final query = ref.watch(queryProvider);

  if (query.trim().isEmpty) return [];

  return isar.communicationSymbols
      .where()
      .wordsElementStartsWith(query)
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
        child: Scaffold(
            appBar: const SearchAppBar(),
            body: results == null || results.isEmpty
                ? const NoResultsScreen()
                : AlignedGridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    itemCount: results.length,
                    padding: const EdgeInsets.all(12.0),
                    itemBuilder: (context, index) {
                      final e = results[index];
                      return SymbolCard(
                        symbol: e,
                        onTapActions: const [SymbolOnTapAction.select],
                      );
                    })));
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/could-not-find-anything-symbol-arrasac.png',
                width: MediaQuery.sizeOf(context).shortestSide / 2,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                "Hmm.. nie znaleźliśmy wyników dla \"$search\"",
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  ConsumerState<SearchAppBar> createState() => _SearchAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends ConsumerState<SearchAppBar> {
  final _debounce = Debouncer(const Duration(milliseconds: 300));
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final areSelected = ref.watch(areSymbolsSelectedProvider);

    Widget? leading;
    List<Widget>? actions;
    Widget? title;

    if (areSelected) {
      leading = const CancelAction();
      actions = [const PinSelectedSymbolAction(), const DeleteForeverAction()];
    } else {
      leading = const BackAction();
      title = TextField(
        focusNode: focusNode,
        style: theme.textTheme.titleLarge,
        onChanged: (value) {
          _debounce(
              () => ref.read(queryProvider.notifier).update((state) => value));
        },
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(hintText: "Szukaj"),
      );
    }

    return AppBar(
      leading: leading,
      title: title,
      actions: actions,
    );
  }
}
