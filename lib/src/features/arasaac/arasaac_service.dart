import 'dart:convert';

import 'package:aac/src/features/symbols/settings/utils/randomise_symbol.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'arasaac_service.g.dart';

class ArasaacService {
  final Client client;
  static const baseEndpoint = "https://api.arasaac.org/api";

  ArasaacService({required this.client});

  /// [language]: "en", "pl"
  /// [resolution]: 300, 500, 2500
  Future<List<String>> search(
      String language, int resolution, String query) async {
    assert(["en", "pl"].contains(language), "Unsupported language");
    assert([300, 500, 2500].contains(resolution), "Unsupported resolution");

    if (query.isEmpty) return [];

    final endpoint = "$baseEndpoint/pictograms/$language/search/$query";

    final Response res;

    try {
      res = await http.get(Uri.parse(endpoint));
    } catch (e) {
      return [];
    }

    if (!res.ok) return [];

    final imageUrlList = <String>[];
    for (final e in (jsonDecode(res.body) as List)) {
      final id = e["_id"];
      imageUrlList.add(
          "https://static.arasaac.org/pictograms/$id/${id}_$resolution.png");
    }

    return imageUrlList;
  }
}

@riverpod
ArasaacService arasaacService(Ref ref) {
  final client = http.Client();
  return ArasaacService(client: client);
}

@riverpod
Future<List<String>> arasaacSearchResults(Ref ref, String query) async {
  var didDispose = false;
  ref.onDispose(() => didDispose = true);

  await Future<void>.delayed(const Duration(milliseconds: 500));

  if (didDispose) {
    throw Exception('Cancelled');
  }

  final client = http.Client();
  final arasaacService = ArasaacService(client: client);

  return arasaacService.search("pl", 300, query);
}
