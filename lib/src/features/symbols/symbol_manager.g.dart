// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(symbolManager)
final symbolManagerProvider = SymbolManagerProvider._();

final class SymbolManagerProvider
    extends $FunctionalProvider<SymbolManager, SymbolManager, SymbolManager>
    with $Provider<SymbolManager> {
  SymbolManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'symbolManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$symbolManagerHash();

  @$internal
  @override
  $ProviderElement<SymbolManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SymbolManager create(Ref ref) {
    return symbolManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymbolManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymbolManager>(value),
    );
  }
}

String _$symbolManagerHash() => r'e1efa52c55580f0c367d8ffc611bede89f2274d5';
