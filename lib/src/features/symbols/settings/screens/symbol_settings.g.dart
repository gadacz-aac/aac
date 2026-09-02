// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(defaultImagePath)
final defaultImagePathProvider = DefaultImagePathProvider._();

final class DefaultImagePathProvider
    extends $FunctionalProvider<String, String, String> with $Provider<String> {
  DefaultImagePathProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'defaultImagePathProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$defaultImagePathHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return defaultImagePath(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$defaultImagePathHash() => r'97674549362443fd5229958d6420c6a497000cae';

@ProviderFor(initialValues)
final initialValuesProvider = InitialValuesProvider._();

final class InitialValuesProvider extends $FunctionalProvider<SymbolEditModel,
    SymbolEditModel, SymbolEditModel> with $Provider<SymbolEditModel> {
  InitialValuesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'initialValuesProvider',
          isAutoDispose: true,
          dependencies: <ProviderOrFamily>[],
          $allTransitiveDependencies: <ProviderOrFamily>[],
        );

  @override
  String debugGetCreateSourceHash() => _$initialValuesHash();

  @$internal
  @override
  $ProviderElement<SymbolEditModel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SymbolEditModel create(Ref ref) {
    return initialValues(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymbolEditModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SymbolEditModel>(value),
    );
  }
}

String _$initialValuesHash() => r'b8639f88ce4cb8bfe651db984499cdc3d7409c08';
