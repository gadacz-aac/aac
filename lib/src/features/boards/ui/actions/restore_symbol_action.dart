import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/bin/bin_manager.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestoreSymbolAction extends ConsumerWidget {
  const RestoreSymbolAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.restore),
      tooltip: AppLocalizations.of(context).restore,
      onPressed: () {
        final symbolManager = ref.read(binManagerProvider);
        final selectedSymbols = [...ref.read(selectedSymbolsProvider).state];
        ref.read(selectedSymbolsProvider).clear();

        symbolManager.restoreSymbols(selectedSymbols);
      },
    );
  }
}
