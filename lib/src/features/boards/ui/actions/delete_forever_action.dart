import 'package:aac/l10n/app_localizations.dart';
import 'package:aac/src/features/symbols/bin/bin_manager.dart';
import 'package:aac/src/features/symbols/search/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteForeverAction extends ConsumerWidget {
  const DeleteForeverAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selectedSymbols = ref.watch(selectedSymbolsProvider).state;

    return IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: l10n.deleteForever,
        onPressed: () {
          showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(l10n.deleteForever),
              content: Text(l10n.deleteForeverConfirm),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () {
                    final symbolManager = ref.watch(binManagerProvider);
                    // state is mutable
                    final symbols = [...selectedSymbols];
                    ref.read(selectedSymbolsProvider).clear();
                    symbolManager.deleteSymbols(symbols);
                    Navigator.pop(context);
                  },
                  child: Text(l10n.delete),
                ),
              ],
            ),
          );
        });
  }
}
