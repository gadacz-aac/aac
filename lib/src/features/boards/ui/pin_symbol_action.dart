import 'dart:async';

import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final searchedSymbolProvider =
    FutureProvider<List<CommunicationSymbol>>((ref) async {
  final isar = ref.watch(isarPod);
  final query = ref.watch(queryProvider);

  if (query.trim().isEmpty) return [];

  return isar.communicationSymbols
      .where()
      .wordsElementStartsWith(query)
      .findAll();
});

final queryProvider = StateProvider((ref) => "");

class Debouncer {
  Timer? _timer;
  final Duration _duration;

  Debouncer(this._duration);

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(_duration, () => callback());
  }

  void dispose() {
    _timer?.cancel();
  }
}

class PinSymbolAction extends ConsumerWidget {
  const PinSymbolAction({super.key, required this.board});

  final Board board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () async {
          final symbols = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SymbolSearchScreen()));

          ref.read(symbolManagerProvider).pinSymbolsToBoard(symbols, board);
        },
        icon: const Icon(Icons.push_pin));
  }
}

class SymbolSearchScreen extends ConsumerStatefulWidget {
  const SymbolSearchScreen({super.key});

  @override
  ConsumerState<SymbolSearchScreen> createState() => _SymbolSearchScreenState();
}

class _SymbolSearchScreenState extends ConsumerState<SymbolSearchScreen> {
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
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              title: TextField(
                focusNode: focusNode,
                style: theme.textTheme.titleLarge,
                onChanged: (value) {
                  _debounce(() => ref
                      .read(queryProvider.notifier)
                      .update((state) => value));
                },
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(hintText: "Szukaj"),
              ),
              actions: null,
            ),
            body: results == null || results.isEmpty
                ? const Center(child: Text("Jak pusto"))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final symbol = results[index];
                      return ListTile(
                        leading: Image.asset("assets/oops-steve-carell.gif"),
                        title: Text(symbol.label),
                        onTap: () => Navigator.pop(context, [symbol]),
                      );
                    },
                  )));
  }
}
