// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deletedSymbols)
const deletedSymbolsProvider = DeletedSymbolsProvider._();

final class DeletedSymbolsProvider extends $FunctionalProvider<
        AsyncValue<List<CommunicationSymbol>>,
        List<CommunicationSymbol>,
        Stream<List<CommunicationSymbol>>>
    with
        $FutureModifier<List<CommunicationSymbol>>,
        $StreamProvider<List<CommunicationSymbol>> {
  const DeletedSymbolsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'deletedSymbolsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$deletedSymbolsHash();

  @$internal
  @override
  $StreamProviderElement<List<CommunicationSymbol>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<CommunicationSymbol>> create(Ref ref) {
    return deletedSymbols(ref);
  }
}

String _$deletedSymbolsHash() => r'eeeb4b9d6b48fc8173e97a650b5098f0e2172ad2';
