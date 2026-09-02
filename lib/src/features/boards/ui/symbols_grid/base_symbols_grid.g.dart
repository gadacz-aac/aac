// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_symbols_grid.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(childSymbol)
final childSymbolProvider = ChildSymbolFamily._();

final class ChildSymbolProvider extends $FunctionalProvider<
        AsyncValue<List<ChildCommunicationSymbol>>,
        List<ChildCommunicationSymbol>,
        Stream<List<ChildCommunicationSymbol>>>
    with
        $FutureModifier<List<ChildCommunicationSymbol>>,
        $StreamProvider<List<ChildCommunicationSymbol>> {
  ChildSymbolProvider._(
      {required ChildSymbolFamily super.from,
      required (
        int,
        bool,
      )
          super.argument})
      : super(
          retry: null,
          name: r'childSymbolProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$childSymbolHash();

  @override
  String toString() {
    return r'childSymbolProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<ChildCommunicationSymbol>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<ChildCommunicationSymbol>> create(Ref ref) {
    final argument = this.argument as (
      int,
      bool,
    );
    return childSymbol(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ChildSymbolProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$childSymbolHash() => r'6164df1038c542ac9987c49ae24856fb405b9b34';

final class ChildSymbolFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<List<ChildCommunicationSymbol>>,
            (
              int,
              bool,
            )> {
  ChildSymbolFamily._()
      : super(
          retry: null,
          name: r'childSymbolProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ChildSymbolProvider call(
    int id, [
    bool isDeleted = false,
  ]) =>
      ChildSymbolProvider._(argument: (
        id,
        isDeleted,
      ), from: this);

  @override
  String toString() => r'childSymbolProvider';
}
