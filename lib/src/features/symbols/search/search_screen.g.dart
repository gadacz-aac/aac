// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchedSymbol)
const searchedSymbolProvider = SearchedSymbolProvider._();

final class SearchedSymbolProvider extends $FunctionalProvider<
        AsyncValue<List<CommunicationSymbol>>,
        List<CommunicationSymbol>,
        FutureOr<List<CommunicationSymbol>>>
    with
        $FutureModifier<List<CommunicationSymbol>>,
        $FutureProvider<List<CommunicationSymbol>> {
  const SearchedSymbolProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchedSymbolProvider',
          isAutoDispose: false,
          dependencies: const <ProviderOrFamily>[localQueryProvider],
          $allTransitiveDependencies: const <ProviderOrFamily>[
            SearchedSymbolProvider.$allTransitiveDependencies0,
          ],
        );

  static const $allTransitiveDependencies0 = localQueryProvider;

  @override
  String debugGetCreateSourceHash() => _$searchedSymbolHash();

  @$internal
  @override
  $FutureProviderElement<List<CommunicationSymbol>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommunicationSymbol>> create(Ref ref) {
    return searchedSymbol(ref);
  }
}

String _$searchedSymbolHash() => r'6440e4966518371770787e2bb497a099d258ae9d';

@ProviderFor(searchedBoard)
const searchedBoardProvider = SearchedBoardProvider._();

final class SearchedBoardProvider extends $FunctionalProvider<
        AsyncValue<List<Board>>, List<Board>, FutureOr<List<Board>>>
    with $FutureModifier<List<Board>>, $FutureProvider<List<Board>> {
  const SearchedBoardProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchedBoardProvider',
          isAutoDispose: false,
          dependencies: const <ProviderOrFamily>[localQueryProvider],
          $allTransitiveDependencies: const <ProviderOrFamily>[
            SearchedBoardProvider.$allTransitiveDependencies0,
          ],
        );

  static const $allTransitiveDependencies0 = localQueryProvider;

  @override
  String debugGetCreateSourceHash() => _$searchedBoardHash();

  @$internal
  @override
  $FutureProviderElement<List<Board>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Board>> create(Ref ref) {
    return searchedBoard(ref);
  }
}

String _$searchedBoardHash() => r'dfd4319206e46ac4faa4275f96a106d7e32faf72';

@ProviderFor(LocalQuery)
const localQueryProvider = LocalQueryProvider._();

final class LocalQueryProvider extends $NotifierProvider<LocalQuery, String> {
  const LocalQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'localQueryProvider',
          isAutoDispose: false,
          dependencies: const <ProviderOrFamily>[],
          $allTransitiveDependencies: const <ProviderOrFamily>[],
        );

  @override
  String debugGetCreateSourceHash() => _$localQueryHash();

  @$internal
  @override
  LocalQuery create() => LocalQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$localQueryHash() => r'8a2ebcf4039004613f40dd3224fb2292c9d83c08';

abstract class _$LocalQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Query)
const queryProvider = QueryProvider._();

final class QueryProvider extends $NotifierProvider<Query, String> {
  const QueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'queryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$queryHash();

  @$internal
  @override
  Query create() => Query();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$queryHash() => r'838c319cdf1ac7f81b68e573cb21c9d70c4c9e22';

abstract class _$Query extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
