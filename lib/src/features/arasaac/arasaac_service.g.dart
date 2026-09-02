// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arasaac_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(arasaacService)
final arasaacServiceProvider = ArasaacServiceProvider._();

final class ArasaacServiceProvider
    extends $FunctionalProvider<ArasaacService, ArasaacService, ArasaacService>
    with $Provider<ArasaacService> {
  ArasaacServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'arasaacServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$arasaacServiceHash();

  @$internal
  @override
  $ProviderElement<ArasaacService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ArasaacService create(Ref ref) {
    return arasaacService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArasaacService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArasaacService>(value),
    );
  }
}

String _$arasaacServiceHash() => r'65d25f00794e06c424e5d66adc919042e4af86db';

@ProviderFor(arasaacSearchResults)
final arasaacSearchResultsProvider = ArasaacSearchResultsFamily._();

final class ArasaacSearchResultsProvider extends $FunctionalProvider<
        AsyncValue<List<String>>, List<String>, FutureOr<List<String>>>
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  ArasaacSearchResultsProvider._(
      {required ArasaacSearchResultsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'arasaacSearchResultsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$arasaacSearchResultsHash();

  @override
  String toString() {
    return r'arasaacSearchResultsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as String;
    return arasaacSearchResults(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ArasaacSearchResultsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$arasaacSearchResultsHash() =>
    r'a73071593ccacb084bda73c4c429902186065e2c';

final class ArasaacSearchResultsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, String> {
  ArasaacSearchResultsFamily._()
      : super(
          retry: null,
          name: r'arasaacSearchResultsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ArasaacSearchResultsProvider call(
    String query,
  ) =>
      ArasaacSearchResultsProvider._(argument: query, from: this);

  @override
  String toString() => r'arasaacSearchResultsProvider';
}
