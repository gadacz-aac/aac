import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateBoardScreen extends ConsumerWidget {
  const CreateBoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 29.0, vertical: 27.0),
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Podpis",
          ),
        ),
      ]),
    );
  }
}
