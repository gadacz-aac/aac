import 'package:aac/src/features/symbols/search/search_screen.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
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
      tooltip: "Przywróć",
      onPressed: () {
        showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            bool unpinSymbols = false;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text("Przywracanie symboli"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text("Czy chcesz odzyskać wybrane elementy?"),
                      CheckboxListTile(
                        title: const Text(
                          "Pozostaw w odpiętych symbolach bez umieszczania na tablicach",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: unpinSymbols,
                        onChanged: (bool? value) {
                          setState(() {
                            unpinSymbols = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Anuluj'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final symbolManager = ref.read(symbolManagerProvider);
                        final selectedSymbols = [...ref.read(selectedSymbolsProvider).state];
                        ref.read(selectedSymbolsProvider).clear();

                        if (unpinSymbols) {
                          await symbolManager.unpinSymbolsFromEveryBoard(selectedSymbols);
                        } else {
                          await symbolManager.restoreSymbols(selectedSymbols);
                        }
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Przywróć'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}


