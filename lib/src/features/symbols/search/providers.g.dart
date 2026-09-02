// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchedSymbol)
final searchedSymbolProvider = SearchedSymbolProvider._();

final class SearchedSymbolProvider extends $FunctionalProvider<
        AsyncValue<List<CommunicationSymbol>>,
        List<CommunicationSymbol>,
        FutureOr<List<CommunicationSymbol>>>
    with
        $FutureModifier<List<CommunicationSymbol>>,
        $FutureProvider<List<CommunicationSymbol>> {
  SearchedSymbolProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchedSymbolProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

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

String _$searchedSymbolHash() => r'b844d8eb8a2aaccc53f7b60f5a926e9581cec8f4';

@ProviderFor(searchedBoard)
final searchedBoardProvider = SearchedBoardProvider._();

final class SearchedBoardProvider extends $FunctionalProvider<
        AsyncValue<List<Board>>, List<Board>, FutureOr<List<Board>>>
    with $FutureModifier<List<Board>>, $FutureProvider<List<Board>> {
  SearchedBoardProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchedBoardProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

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

String _$searchedBoardHash() => r'6946eda73773291405f8a400994a60bd5a921116';

@ProviderFor(LocalQuery)
final localQueryProvider = LocalQueryProvider._();

final class LocalQueryProvider extends $NotifierProvider<LocalQuery, String> {
  LocalQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'localQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
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

String _$localQueryHash() => r'00d36b4e4a94cc3fcf1a3b64f9555126d3581430';

abstract class _$LocalQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(Query)
final queryProvider = QueryProvider._();

final class QueryProvider extends $NotifierProvider<Query, String> {
  QueryProvider._()
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
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
