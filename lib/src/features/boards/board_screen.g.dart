// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(boardId)
final boardIdProvider = BoardIdProvider._();

final class BoardIdProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  BoardIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'boardIdProvider',
          isAutoDispose: true,
          dependencies: <ProviderOrFamily>[],
          $allTransitiveDependencies: <ProviderOrFamily>[],
        );

  @override
  String debugGetCreateSourceHash() => _$boardIdHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return boardId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$boardIdHash() => r'3e8e0980138057548b10a7e72c77240573dbb08b';

@ProviderFor(IsParentMode)
final isParentModeProvider = IsParentModeProvider._();

final class IsParentModeProvider extends $NotifierProvider<IsParentMode, bool> {
  IsParentModeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isParentModeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isParentModeHash();

  @$internal
  @override
  IsParentMode create() => IsParentMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isParentModeHash() => r'e5db071ba7ba2a4ee1e4d9849675303e89275c9d';

abstract class _$IsParentMode extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}
