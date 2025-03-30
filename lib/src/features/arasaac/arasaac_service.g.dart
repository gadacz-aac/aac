// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arasaac_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$arasaacServiceHash() => r'be3947c3562f058ba21493b8f1866a158fa49f39';

/// See also [arasaacService].
@ProviderFor(arasaacService)
final arasaacServiceProvider = AutoDisposeProvider<ArasaacService>.internal(
  arasaacService,
  name: r'arasaacServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$arasaacServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ArasaacServiceRef = AutoDisposeProviderRef<ArasaacService>;
String _$arasaacSearchResultsHash() =>
    r'f2d18ac4fc7c0ab90850363c6d4d871a656eeb46';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [arasaacSearchResults].
@ProviderFor(arasaacSearchResults)
const arasaacSearchResultsProvider = ArasaacSearchResultsFamily();

/// See also [arasaacSearchResults].
class ArasaacSearchResultsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [arasaacSearchResults].
  const ArasaacSearchResultsFamily();

  /// See also [arasaacSearchResults].
  ArasaacSearchResultsProvider call(
    String query,
  ) {
    return ArasaacSearchResultsProvider(
      query,
    );
  }

  @override
  ArasaacSearchResultsProvider getProviderOverride(
    covariant ArasaacSearchResultsProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'arasaacSearchResultsProvider';
}

/// See also [arasaacSearchResults].
class ArasaacSearchResultsProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [arasaacSearchResults].
  ArasaacSearchResultsProvider(
    String query,
  ) : this._internal(
          (ref) => arasaacSearchResults(
            ref as ArasaacSearchResultsRef,
            query,
          ),
          from: arasaacSearchResultsProvider,
          name: r'arasaacSearchResultsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$arasaacSearchResultsHash,
          dependencies: ArasaacSearchResultsFamily._dependencies,
          allTransitiveDependencies:
              ArasaacSearchResultsFamily._allTransitiveDependencies,
          query: query,
        );

  ArasaacSearchResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(ArasaacSearchResultsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArasaacSearchResultsProvider._internal(
        (ref) => create(ref as ArasaacSearchResultsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _ArasaacSearchResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArasaacSearchResultsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ArasaacSearchResultsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _ArasaacSearchResultsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with ArasaacSearchResultsRef {
  _ArasaacSearchResultsProviderElement(super.provider);

  @override
  String get query => (origin as ArasaacSearchResultsProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
