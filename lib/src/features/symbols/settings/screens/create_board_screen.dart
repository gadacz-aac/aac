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
  late bool isUnlimitedRows = widget.params.rowCount == null;
  late final TextEditingController nameController;
  late final TextEditingController columnCountController;
  late final TextEditingController rowCountController;

  @override
  void initState() {
    super.initState();
    isUnlimitedRows = widget.params.rowCount == null;
    nameController = TextEditingController(text: widget.params.name);
    columnCountController =
        TextEditingController(text: "${widget.params.columnCount}");
    rowCountController =
        TextEditingController(text: "${widget.params.rowCount}");
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    columnCountController.dispose();
    rowCountController.dispose();
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
              const SizedBox(
                width: 14,
              ),
              const Text("x"),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                  child: GenericNumberField(
                      controller: rowCountController,
                      enabled: !isUnlimitedRows,
                      name: "dupa",
                      labelText: "Liczba wierszy"))
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          ListTile(
            title: const Text("Nieograniczona liczba wierszy"),
            trailing: Switch(
                value: isUnlimitedRows,
                onChanged: (value) {
                  setState(() {
                    isUnlimitedRows = value;
                  });
                }),
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
                            columnCount:
                                int.tryParse(columnCountController.text),
                            rowCount: isUnlimitedRows
                                ? null
                                : int.tryParse(rowCountController.text)));
                  },
                  child: const Text("Zapisz"))
            ],
          )
        ]),
      ),
    );
  }
}
