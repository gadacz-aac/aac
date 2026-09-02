// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backupManager)
final backupManagerProvider = BackupManagerProvider._();

final class BackupManagerProvider
    extends $FunctionalProvider<BackupManager, BackupManager, BackupManager>
    with $Provider<BackupManager> {
  BackupManagerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'backupManagerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$backupManagerHash();

  @$internal
  @override
  $ProviderElement<BackupManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupManager create(Ref ref) {
    return backupManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupManager>(value),
    );
  }
}

String _$backupManagerHash() => r'25c77e9019df3cf12c54601bae9fd3acfc69fbf3';

@ProviderFor(backupProgress)
final backupProgressProvider = BackupProgressProvider._();

final class BackupProgressProvider
    extends $FunctionalProvider<AsyncValue<double>, double, Stream<double>>
    with $FutureModifier<double>, $StreamProvider<double> {
  BackupProgressProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'backupProgressProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$backupProgressHash();

  @$internal
  @override
  $StreamProviderElement<double> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<double> create(Ref ref) {
    return backupProgress(ref);
  }
}

String _$backupProgressHash() => r'add116e68d9f9de6219e43282b0714541566d0a3';
