// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(binManager)
const binManagerProvider = BinManagerProvider._();

final class BinManagerProvider
    extends $FunctionalProvider<BinManager, BinManager, BinManager>
    with $Provider<BinManager> {
  const BinManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'binManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$binManagerHash();

  @$internal
  @override
  $ProviderElement<BinManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BinManager create(Ref ref) {
    return binManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BinManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BinManager>(value),
    );
  }
}

String _$binManagerHash() => r'fac059a32af7b5841ee13ea315db4bb1f8a7b7ee';
