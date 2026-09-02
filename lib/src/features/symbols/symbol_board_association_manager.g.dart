// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_board_association_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(symbolBoardAssociationManager)
final symbolBoardAssociationManagerProvider =
    SymbolBoardAssociationManagerProvider._();

final class SymbolBoardAssociationManagerProvider extends $FunctionalProvider<
        SymbolBoardAssociationManager,
        SymbolBoardAssociationManager,
        SymbolBoardAssociationManager>
    with $Provider<SymbolBoardAssociationManager> {
  SymbolBoardAssociationManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'symbolBoardAssociationManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$symbolBoardAssociationManagerHash();

  @$internal
  @override
  $ProviderElement<SymbolBoardAssociationManager> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SymbolBoardAssociationManager create(Ref ref) {
    return symbolBoardAssociationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SymbolBoardAssociationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<SymbolBoardAssociationManager>(value),
    );
  }
}

String _$symbolBoardAssociationManagerHash() =>
    r'99890a70cc5bf015312b9d4e2d2d688d6314f381';
