// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ttsManager)
const ttsManagerProvider = TtsManagerProvider._();

final class TtsManagerProvider
    extends $FunctionalProvider<TtsManager, TtsManager, TtsManager>
    with $Provider<TtsManager> {
  const TtsManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ttsManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ttsManagerHash();

  @$internal
  @override
  $ProviderElement<TtsManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TtsManager create(Ref ref) {
    return ttsManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TtsManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TtsManager>(value),
    );
  }
}

String _$ttsManagerHash() => r'fefffd97683351475854cf0abf15b0d165e6d602';
