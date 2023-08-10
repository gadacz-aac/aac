import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final searchedSymbolProvider =
    FutureProvider<List<CommunicationSymbol>>((ref) async {
  final isar = ref.watch(isarPod);
  final query = ref.watch(queryProvider);

  return isar.communicationSymbols
      .where()
      .wordsElementStartsWith(query)
      .findAll();
});

final queryProvider = StateProvider((ref) => "");

class PinSymbolAction extends StatelessWidget {
  const PinSymbolAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SymbolSearchScreen()));
          // showSearch(context: context, delegate: SymbolSearchDelegate());
        },
        icon: const Icon(Icons.push_pin));
  }
}

class SymbolSearchScreen extends ConsumerWidget {
  const SymbolSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchedSymbolProvider).valueOrNull;
    final theme = Theme.of(context);
    final appBarTheme = theme.copyWith(
      appBarTheme: AppBarTheme(
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
                // controller: widget.delegate._queryTextController,
                // focusNode: focusNode,
                style: theme.textTheme.titleLarge,
                onChanged: (value) =>
                    ref.read(queryProvider.notifier).update((_) => value),
                // textInputAction: widget.delegate.textInputAction,
                decoration: const InputDecoration(hintText: "Szukaj"),
              ),
              actions: null,
            ),
            body: results == null || results.isEmpty
                ? const Center(child: Text("Jak pusto"))
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
                      return ListTile(
                        leading: SymbolImage(item.imagePath),
                        title: Text(item.label),
                      );
                    },
                  )));
  }
}

class SymbolSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: List.filled(8, 0)
          .map((e) => const ListTile(
                title: Text("results"),
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: List.filled(8, 0)
          .map((e) => const ListTile(
                title: Text("suggestion"),
              ))
          .toList(),
    );
  }
}
