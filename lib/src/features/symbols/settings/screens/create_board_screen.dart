import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/form/widgets/number_field.dart';
import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:aac/src/shared/ui/button.dart';
import 'package:flutter/material.dart';

class CreateBoardScreen extends StatefulWidget {
  const CreateBoardScreen({super.key, required this.params});

  final BoardEditingParams params;

  @override
  State<CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends State<CreateBoardScreen> {
  late final TextEditingController nameController;
  late final TextEditingController columnCountController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.params.name);
    columnCountController =
        TextEditingController(text: "${widget.params.columnCount}");
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    columnCountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 27.0),
        child: Column(children: [
          GenericTextField(controller: nameController, labelText: "Nazwa"),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Expanded(
                  child: GenericNumberField(
                name: "dupa",
                controller: columnCountController,
                labelText: "Liczba Kolumn",
              )),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                onPressed: Navigator.of(context).pop,
                type: ButtonType.noBackground,
                child: const Text("Anuluj"),
              ),
              Button(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        BoardEditingParams(
                            name: nameController.text,
                            id: widget.params.id,
                            columnCount:
                                int.tryParse(columnCountController.text),)); },
                  child: const Text("Zapisz"))
            ],
          )
        ]),
      ),
    );
  }
}
