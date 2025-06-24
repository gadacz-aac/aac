// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_picker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardNotifierHash() => r'b7ae721e67f904d21cfbdd08e3c480e35ecdff91';

/// See also [BoardNotifier].
@ProviderFor(BoardNotifier)
final boardNotifierProvider =
    AutoDisposeAsyncNotifierProvider<BoardNotifier, BoardEditModel?>.internal(
  BoardNotifier.new,
  name: r'boardNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$boardNotifierHash,
  dependencies: <ProviderOrFamily>[initialValuesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    initialValuesProvider,
    ...?initialValuesProvider.allTransitiveDependencies
  },
);

typedef _$BoardNotifier = AutoDisposeAsyncNotifier<BoardEditModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
