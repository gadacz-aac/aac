// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_symbols_grid.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$childSymbolHash() => r'308815decb0c9aba5a9674a1b4e3a4893d63e689';

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

/// See also [childSymbol].
@ProviderFor(childSymbol)
const childSymbolProvider = ChildSymbolFamily();

/// See also [childSymbol].
class ChildSymbolFamily extends Family<AsyncValue<List<CommunicationSymbol>>> {
  /// See also [childSymbol].
  const ChildSymbolFamily();

  /// See also [childSymbol].
  ChildSymbolProvider call(
    int id,
  ) {
    return ChildSymbolProvider(
      id,
    );
  }

  @override
  ChildSymbolProvider getProviderOverride(
    covariant ChildSymbolProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'childSymbolProvider';
}

/// See also [childSymbol].
class ChildSymbolProvider
    extends AutoDisposeStreamProvider<List<CommunicationSymbol>> {
  /// See also [childSymbol].
  ChildSymbolProvider(
    int id,
  ) : this._internal(
          (ref) => childSymbol(
            ref as ChildSymbolRef,
            id,
          ),
          from: childSymbolProvider,
          name: r'childSymbolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$childSymbolHash,
          dependencies: ChildSymbolFamily._dependencies,
          allTransitiveDependencies:
              ChildSymbolFamily._allTransitiveDependencies,
          id: id,
        );

  ChildSymbolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    Stream<List<CommunicationSymbol>> Function(ChildSymbolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChildSymbolProvider._internal(
        (ref) => create(ref as ChildSymbolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<CommunicationSymbol>> createElement() {
    return _ChildSymbolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChildSymbolProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChildSymbolRef
    on AutoDisposeStreamProviderRef<List<CommunicationSymbol>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ChildSymbolProviderElement
    extends AutoDisposeStreamProviderElement<List<CommunicationSymbol>>
    with ChildSymbolRef {
  _ChildSymbolProviderElement(super.provider);

  @override
  int get id => (origin as ChildSymbolProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
