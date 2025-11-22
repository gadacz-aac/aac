import 'package:aac/src/database/daos/board_dao.dart';
import 'package:aac/src/database/daos/symbol_dao.dart';
import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/boards/ui/actions/move_symbol_to_bin_action.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:aac/src/features/symbols/search/app_bar_actions.dart';
import 'package:aac/src/features/symbols/search/symbol_search_filters.dart';
import 'package:aac/src/shared/ui/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:aac/src/shared/ui/scaffold.dart';
import 'package:riverpod_annotation/experimental/scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_screen.g.dart';

@Riverpod(dependencies: [LocalQuery], keepAlive: true)
Future<List<CommunicationSymbol>> searchedSymbol(Ref ref) async {
  final query = ref.watch(localQueryProvider);

  final color = ref.watch(symbolSearchColorFilterProvider)?.code;
  final onlyPinned = ref.watch(symbolSearchOnlyPinnedFilterProvider);

  final res = ref
      .read(symbolDaoProvider)
      .searchSymbol(query: query, onlyPinned: onlyPinned, color: color)
      .map(CommunicationSymbol.fromEntity)
      .get();

  return res;
}

@Riverpod(dependencies: [LocalQuery], keepAlive: true)
Future<List<Board>> searchedBoard(Ref ref) async {
  final query = ref.watch(localQueryProvider);

  return ref
      .read(boardDaoProvider)
      .searchBoard(query: query)
      .map(Board.fromEntity)
      .get();
}

@Riverpod(dependencies: [], keepAlive: true)
class LocalQuery extends _$LocalQuery {
  @override
  String build() => "";

  @override
  set state(String newState) => super.state = newState;
  String update(String Function(String state) cb) => state = cb(state);
}

@riverpod
class Query extends _$Query {
  @override
  String build() => "";

  @override
  set state(String newState) => super.state = newState;
  String update(String Function(String state) cb) => state = cb(state);
}

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

@Dependencies([searchedSymbol, searchedBoard, LocalQuery])
class AacLocalSearchScreen extends ConsumerStatefulWidget {
  const AacLocalSearchScreen({super.key});

  @override
  ConsumerState<AacLocalSearchScreen> createState() =>
      _AacLocalSearchScreenState();
}

class _AacLocalSearchScreenState extends ConsumerState<AacLocalSearchScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = [
    Tab(
      text: "Symbole",
    ),
    Tab(
      text: "Tablice",
    )
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final areSymbolsSelected = ref.watch(areSymbolsSelectedProvider);

    List<Widget> actions = [];
    Widget? flexibleSpace;

    if (areSymbolsSelected) {
      actions = [
        const PinSelectedSymbolAction(),
        const MoveSymbolToBinAction()
      ];
    } else {
      flexibleSpace = SafeArea(
        child: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      animationDuration: Duration.zero,
      child: AacScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: areSymbolsSelected ? CancelAction() : null,
          flexibleSpace: flexibleSpace,
          actions: actions,
        ),
        body: TabBarView(controller: _tabController, children: [
          ProviderScope(
            overrides: [localQueryProvider],
            child: Consumer(
              builder: (_, ref, __) {
                return SearchScreen(
                  asyncValue: ref.watch(searchedSymbolProvider),
                  what: "symboli",
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
                  onChanged: (val) {
                    setState(() {
                      ref.read(localQueryProvider.notifier).state = val;
                    });
                  },
                );
              },
            ),
          ),
          ProviderScope(
            overrides: [localQueryProvider],
            child: Consumer(builder: (_, ref, __) {
              return SearchScreen(
                  asyncValue: ref.watch(searchedBoardProvider),
                  what: "tablic",
                  onChanged: (val) {
                    setState(() {
                      ref.read(localQueryProvider.notifier).state = val;
                    });
                  },
                  resultBuilder: (results) => ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final e = results[index];

                        return ListTile(
                          title: Text(e.name),
                        );
                      }));
            }),
          )
        ]),
      ),
    );
  }
}

class SearchScreen<T> extends ConsumerStatefulWidget {
  const SearchScreen(
      {super.key,
      required this.onChanged,
      required this.asyncValue,
      required this.what,
      required this.resultBuilder});

  final Function(String value) onChanged;
  final AsyncValue<List<T>> asyncValue;
  final String what;
  final Widget Function(List<T>) resultBuilder;

  @override
  ConsumerState<SearchScreen<T>> createState() => _SearchScreenState<T>();
}

class _SearchScreenState<T> extends ConsumerState<SearchScreen<T>> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<T>? results = widget.asyncValue.value;
    final hasResults = results != null && results.isNotEmpty;

    return PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            ref.read(selectedSymbolsProvider).clear();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!hasResults)
              NoResultsScreen(
                isLoading: widget.asyncValue.isLoading,
                what: widget.what,
              )
            else
              Expanded(
                  child: Builder(
                builder: (_) => widget.resultBuilder(results),
              )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: AacSearchField(
                  controller: controller,
                  placeholder: "Szukaj",
                  onChanged: widget.onChanged),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
              child: SearchFilters(),
            ),
          ],
        ));
  }
}

class NoResultsScreen extends ConsumerWidget {
  const NoResultsScreen(
      {super.key, required this.what, required this.isLoading});

  final String what;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    if (isLoading) return const Spacer();
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Brak pasujących $what",
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Część $what mogła zostać usunięta",
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
