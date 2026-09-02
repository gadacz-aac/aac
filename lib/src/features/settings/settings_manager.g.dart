// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsManager)
final settingsManagerProvider = SettingsManagerProvider._();

final class SettingsManagerProvider extends $FunctionalProvider<SettingsManager,
    SettingsManager, SettingsManager> with $Provider<SettingsManager> {
  SettingsManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsManagerHash();

  @$internal
  @override
  $ProviderElement<SettingsManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsManager create(Ref ref) {
    return settingsManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsManager>(value),
    );
  }
}

String _$settingsManagerHash() => r'c70352fc6aa29f85a05d86bc3ba7a7688d86f3bd';

@ProviderFor(settingsCache)
final settingsCacheProvider = SettingsCacheProvider._();

final class SettingsCacheProvider
    extends $FunctionalProvider<SettingsCache, SettingsCache, SettingsCache>
    with $Provider<SettingsCache> {
  SettingsCacheProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsCacheProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsCacheHash();

  @$internal
  @override
  $ProviderElement<SettingsCache> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsCache create(Ref ref) {
    return settingsCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsCache value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsCache>(value),
    );
  }
}

String _$settingsCacheHash() => r'005b433189ffdd9826d485608da459ab9e4c2502';
