// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_picker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardNotifierHash() => r'9e991b79108341585fb925ed86055365d16f9c2a';

/// See also [BoardNotifier].
@ProviderFor(BoardNotifier)
final boardNotifierProvider = AutoDisposeAsyncNotifierProvider<BoardNotifier,
    BoardEditingParams?>.internal(
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

typedef _$BoardNotifier = AutoDisposeAsyncNotifier<BoardEditingParams?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
