// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_search_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foundBoards)
const foundBoardsProvider = FoundBoardsProvider._();

final class FoundBoardsProvider extends $FunctionalProvider<
        AsyncValue<List<Board>>, List<Board>, FutureOr<List<Board>>>
    with $FutureModifier<List<Board>>, $FutureProvider<List<Board>> {
  const FoundBoardsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'foundBoardsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$foundBoardsHash();

  @$internal
  @override
  $FutureProviderElement<List<Board>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Board>> create(Ref ref) {
    return foundBoards(ref);
  }
}

String _$foundBoardsHash() => r'c4268956a04bf277db63c4b708d5a60b22a2786a';
