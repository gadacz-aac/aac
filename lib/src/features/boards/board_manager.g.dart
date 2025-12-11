// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(boardManager)
const boardManagerProvider = BoardManagerProvider._();

final class BoardManagerProvider
    extends $FunctionalProvider<BoardManager, BoardManager, BoardManager>
    with $Provider<BoardManager> {
  const BoardManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'boardManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$boardManagerHash();

  @$internal
  @override
  $ProviderElement<BoardManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoardManager create(Ref ref) {
    return boardManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardManager>(value),
    );
  }
}

String _$boardManagerHash() => r'6637d8ed08b8c51446c33df61fae4dd5df51d931';
