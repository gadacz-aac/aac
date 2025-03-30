// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isDefaultImageHash() => r'b175de8918b09e2e52b4563e7a68c91716ef1128';

/// See also [isDefaultImage].
@ProviderFor(isDefaultImage)
final isDefaultImageProvider = AutoDisposeProvider<bool>.internal(
  isDefaultImage,
  name: r'isDefaultImageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDefaultImageHash,
  dependencies: <ProviderOrFamily>[imageNotifierProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    imageNotifierProvider,
    ...?imageNotifierProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsDefaultImageRef = AutoDisposeProviderRef<bool>;
String _$imageNotifierHash() => r'71baf68092b30b41619adf92011a5176d837958c';

/// See also [ImageNotifier].
@ProviderFor(ImageNotifier)
final imageNotifierProvider =
    AutoDisposeNotifierProvider<ImageNotifier, String>.internal(
  ImageNotifier.new,
  name: r'imageNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageNotifierHash,
  dependencies: <ProviderOrFamily>[initialValuesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    initialValuesProvider,
    ...?initialValuesProvider.allTransitiveDependencies
  },
);

typedef _$ImageNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
