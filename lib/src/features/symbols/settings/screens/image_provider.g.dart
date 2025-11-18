// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ImageNotifier)
const imageProvider = ImageNotifierProvider._();

final class ImageNotifierProvider
    extends $NotifierProvider<ImageNotifier, String> {
  const ImageNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'imageProvider',
          isAutoDispose: true,
          dependencies: const <ProviderOrFamily>[initialValuesProvider],
          $allTransitiveDependencies: const <ProviderOrFamily>[
            ImageNotifierProvider.$allTransitiveDependencies0,
          ],
        );

  static const $allTransitiveDependencies0 = initialValuesProvider;

  @override
  String debugGetCreateSourceHash() => _$imageNotifierHash();

  @$internal
  @override
  ImageNotifier create() => ImageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$imageNotifierHash() => r'd53a4b77aec51147bfba4671910522fd1f535b13';

abstract class _$ImageNotifier extends $Notifier<String> {
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

@ProviderFor(isDefaultImage)
const isDefaultImageProvider = IsDefaultImageProvider._();

final class IsDefaultImageProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsDefaultImageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isDefaultImageProvider',
          isAutoDispose: true,
          dependencies: const <ProviderOrFamily>[imageProvider],
          $allTransitiveDependencies: const <ProviderOrFamily>[
            IsDefaultImageProvider.$allTransitiveDependencies0,
            IsDefaultImageProvider.$allTransitiveDependencies1,
          ],
        );

  static const $allTransitiveDependencies0 = imageProvider;
  static const $allTransitiveDependencies1 =
      ImageNotifierProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$isDefaultImageHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isDefaultImage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isDefaultImageHash() => r'0b387f05b91ca704f945a36255d356c332406735';
