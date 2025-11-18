// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_picker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BoardNotifier)
const boardProvider = BoardNotifierProvider._();

final class BoardNotifierProvider
    extends $AsyncNotifierProvider<BoardNotifier, BoardEditModel?> {
  const BoardNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'boardProvider',
          isAutoDispose: true,
          dependencies: const <ProviderOrFamily>[initialValuesProvider],
          $allTransitiveDependencies: const <ProviderOrFamily>[
            BoardNotifierProvider.$allTransitiveDependencies0,
          ],
        );

  static const $allTransitiveDependencies0 = initialValuesProvider;

  @override
  String debugGetCreateSourceHash() => _$boardNotifierHash();

  @$internal
  @override
  BoardNotifier create() => BoardNotifier();
}

String _$boardNotifierHash() => r'b7ae721e67f904d21cfbdd08e3c480e35ecdff91';

abstract class _$BoardNotifier extends $AsyncNotifier<BoardEditModel?> {
  FutureOr<BoardEditModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<BoardEditModel?>, BoardEditModel?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<BoardEditModel?>, BoardEditModel?>,
        AsyncValue<BoardEditModel?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
