import 'package:aac/src/database/daos/child_communication_symbol_dao.dart';
import 'package:aac/src/features/boards/board_screen.dart';
import 'package:aac/src/features/boards/ui/actions/move_symbol_to_bin_action.dart';
import 'package:aac/src/features/boards/ui/options/bottom_sheet_options.dart';
import 'package:aac/src/features/symbols/bin/bin_manager.dart';
import 'package:aac/src/features/symbols/bin/bin_screen_board.dart';
import 'package:aac/src/features/symbols/card/symbol_card.dart';
import 'package:aac/src/features/symbols/card/symbol_tap_actions.dart';
import 'package:aac/src/features/symbols/search/app_bar_actions.dart';
import 'package:aac/src/features/symbols/search/no_search_results.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:aac/src/features/symbols/search/symbol_search_filters.dart';
import 'package:aac/src/shared/ui/bottom_sheet_options.dart';
import 'package:aac/src/shared/ui/list.dart';
import 'package:aac/src/shared/ui/scaffold.dart';
import 'package:aac/src/shared/ui/search_input.dart';
import 'package:aac/src/shared/ui/show_more_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AacLocalSearchScreen extends ConsumerStatefulWidget {
  const AacLocalSearchScreen({super.key});

  @override
  ConsumerState<AacLocalSearchScreen> createState() =>
      _AacLocalSearchScreenState();
}

class BoardSearchScreen extends ConsumerWidget {
  const BoardSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchScreen(
        asyncValue: ref.watch(searchedBoardProvider),
        what: "tablic",
        onChanged: (val) {
          ref.read(localQueryProvider.notifier).state = val;
        },
        resultBuilder: (results) => Padding(
              padding: const EdgeInsets.all(12),
              child: AacList.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final e = results[index];

                    return ListTile(
                      title: Text(e.name),
                      trailing: ShowMoreOptions(
                          builder: (context) =>
                              optionsBuilder(context, ref, e.id)),
                    );
                  }),
            ));
  }

  Widget optionsBuilder(BuildContext context, WidgetRef ref, int id) {
    return BottomSheetOptions(
      children: [
        OptionGroup(
          options: [
            Option(
                onTap: () {
                  Navigator.push(context, BoardScreen.page(id));
                },
                icon: Icon(Icons.open_in_new_outlined),
                label: "Otwórz"),
            ProviderScope(
              overrides: [boardIdProvider.overrideWithValue(id)],
              child: EditBoardOption(),
            ),
          ],
        ),
        if (id != 1)
          OptionGroup(
            options: [
              Option(
                  onTap: () async {
                    final symbols = await ref
                        .read(childSymbolDaoProvider)
                        .findByBoardIdWithIsReused(id);

                    if (!context.mounted) {
                      return;
                    }

                    BoardSymbolPicker.openPicker(
                        context,
                        BoardSymbolPicker(
                            id: id,
                            title: "Usuń tablice i symbole",
                            symbols: symbols
                                .map((e) => e..isSelected = !e.isSelected)
                                .toList(),
                            subtitle:
                                "Wybierz symbole, które chcesz \nprzecieść do kosza",
                            subtitle2:
                                "Pamiętaj, że możesz je zawsze przywrócić"),
                        (selected) => ref
                            .read(binManagerProvider)
                            .boardMoveToTrash(id, selected));
                  },
                  icon: Icon(Icons.delete_outlined),
                  label: "Usuń"),
            ],
          ),
      ],
    );
  }
}

class SearchScreen<T> extends ConsumerStatefulWidget {
  final Function(String value) onChanged;

  final AsyncValue<List<T>> asyncValue;
  final String what;
  final Widget Function(List<T>) resultBuilder;
  final Widget? filters;
  const SearchScreen(
      {super.key,
      required this.onChanged,
      required this.asyncValue,
      required this.what,
      required this.resultBuilder,
      this.filters});

  @override
  ConsumerState<SearchScreen<T>> createState() => _SearchScreenState<T>();
}

class SymbolSearchScreen extends ConsumerWidget {
  const SymbolSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchScreen(
      asyncValue: ref.watch(searchedSymbolProvider),
      what: "symboli",
      filters: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
        child: SearchFilters(),
      ),
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
        ref.read(localQueryProvider.notifier).state = val;
      },
    );
  }
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
              // My understanding is that this rule is useful for situations when non overriden provider would break the app - like in a case of providers that throw UnimplementedErrors. But here it doesn't make a difference since we only override the localQuery so that we don't have two providers that serve the same feature
              // ignore: scoped_providers_should_specify_dependencies
              overrides: [searchedSymbolProvider, localQueryProvider],
              child: SymbolSearchScreen()),
          ProviderScope(
              overrides: [searchedBoardProvider, localQueryProvider],
              child: BoardSearchScreen())
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }
}

class _SearchScreenState<T> extends ConsumerState<SearchScreen<T>> {
  final controller = TextEditingController();

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
                title: "Brak pasujących ${widget.what}",
                subtitle: "Część ${widget.what} mogła zostać usunięta",
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
              ),
            ),
            widget.filters ?? SizedBox()
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() => widget.onChanged(controller.text));
  }
}
