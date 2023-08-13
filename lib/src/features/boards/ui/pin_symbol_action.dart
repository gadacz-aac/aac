import 'dart:async';
import 'dart:developer';

import 'package:aac/src/shared/isar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../symbols/model/communication_symbol.dart';

class PinSymbolAction extends StatelessWidget {
  const PinSymbolAction({super.key});

  void _onPressed(context) {
    showSearch(context: context, delegate: PinSymbolSearchDelegate());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => _onPressed(context), icon: const Icon(Icons.push_pin));
  }
}

final symbolSearchProvider = FutureProvider.autoDispose
    .family<List<CommunicationSymbol>, String>((ref, query) async {
  final isar = ref.watch(isarPod);
  return isar.communicationSymbols
      .where()
      .wordsElementStartsWith(query)
      .findAll();
});

class PinSymbolSearchDelegate extends SearchDelegate {
  List<CommunicationSymbol> selected = [];
  String _query = "";
  Timer? _debounce;

  @override
  set query(String value) {
    debounceQuery(value);
    log("object");
    super.query = value;
  }

  void debounceQuery(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    log(value);
    log(_query);
    _debounce = Timer(const Duration(milliseconds: 500), () => _query = value);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        IconButton(
            onPressed: () {
              query = "";
            },
            icon: const Icon(Icons.close))
      ];
    }
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          title: Text("results"),
        ),
        ListTile(
          title: Text(_query),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          title: Text("suggestions"),
        ),
        ListTile(
          title: Text(_query),
        )
      ],
    );
  }
}
