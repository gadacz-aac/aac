import 'package:aac/src/features/symbols/bin/bin_bar.dart';
import 'package:aac/src/features/symbols/bin/bin_screen_board.dart';
import 'package:aac/src/features/symbols/bin/bin_screen_symbol.dart';
import 'package:aac/src/shared/ui/scaffold.dart';
import 'package:flutter/material.dart' hide SelectAction;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinScreen extends ConsumerStatefulWidget {
  const BinScreen({super.key});

  @override
  ConsumerState<BinScreen> createState() => _BinScreenState();
}

class _BinScreenState extends ConsumerState<BinScreen>
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
    return DefaultTabController(
        length: 2,
        animationDuration: Duration.zero,
        child: AacScaffold(
            appBar: BinAppBar(tabs: tabs, tabController: _tabController),
            body: TabBarView(controller: _tabController, children: [
              BinScreenSymbol(),
              BinScreenBoard(),
            ])));
  }
}
