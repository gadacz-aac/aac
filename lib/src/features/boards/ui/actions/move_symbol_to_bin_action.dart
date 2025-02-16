import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoveSymbolToBinAction extends ConsumerWidget {
  const MoveSymbolToBinAction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    throw UnimplementedError();
    // final selectedSymbols = ref.watch(selectedSymbolsProvider).state;

    // final hasChildren = selectedSymbols.any((symbol) => symbol.childBoard.value != null);

    // return IconButton(
    //   icon: const Icon(Icons.delete_outline),
    //   tooltip: "Usuń",
    //   onPressed: () {
    //     showDialog<bool>(
    //       context: context,
    //       builder: (BuildContext context) {
    //         bool deleteAll = true;
    //
    //         return StatefulBuilder(
    //           builder: (BuildContext context, StateSetter setState) {
    //             return AlertDialog(
    //               title: const Text("Usuń"),
    //               content: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: <Widget>[
    //                   Text(
    //                     hasChildren
    //                         ? "Przynajmniej jeden z zaznaczonych symboli może mieć elementy wewnętrzne"
    //                         : "Czy jesteś pewien? Zaznaczone symbole będą usunięte z każdej lokalizacji i przeniesione do kosza. Jeśli chcesz usunąć symbol tylko z jednej tablicy zamiast tego użyj ikony Odpięcia.",
    //                   ),
    //                   if (hasChildren)
    //                     CheckboxListTile(
    //                       title: const Text(
    //                         "Chcę usunąć symbol i wszystkie elementy, które się w nim znajdują",
    //                         style: TextStyle(fontSize: 14),
    //                       ),
    //                       value: deleteAll,
    //                       onChanged: (bool? value) {
    //                         setState(() {
    //                           deleteAll = value ?? false;
    //                         });
    //                       },
    //                     ),
    //                 ],
    //               ),
    //               actions: <Widget>[
    //                 TextButton(
    //                   onPressed: () => Navigator.pop(context),
    //                   child: const Text('Anuluj'),
    //                 ),
    //                 TextButton(
    //                   onPressed: () {
    //                     final symbolManager = ref.watch(symbolManagerProvider);
    //                     final symbols = [...selectedSymbols];
    //                     ref.read(selectedSymbolsProvider).clear();
    //                     
    //                     if (hasChildren) {
    //                       symbolManager.moveSymbolToBin(symbols, deleteAll);
    //                     } else {
    //                       symbolManager.moveSymbolToBin(symbols, false);
    //                     }
    //                     
    //                     Navigator.pop(context);
    //                   },
    //                   child: const Text('Usuń'),
    //                 ),
    //               ],
    //             );
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
