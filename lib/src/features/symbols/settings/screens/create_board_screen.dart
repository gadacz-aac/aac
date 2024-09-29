import 'package:aac/src/features/boards/board_manager.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/shared/form/widgets/number_field.dart';
import 'package:aac/src/shared/form/widgets/text_field.dart';
import 'package:aac/src/shared/ui/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateBoardScreen extends ConsumerStatefulWidget {
  const CreateBoardScreen({super.key, required this.params});

  final BoardEditingParams params;

  @override
  ConsumerState<CreateBoardScreen> createState() => _CreateBoardScreenState();

}

class _CreateBoardScreenState extends ConsumerState<CreateBoardScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController columnCountController;

  bool _isNameUnique = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.params.name);
    columnCountController =
        TextEditingController(text: "${widget.params.columnCount}");
      
    nameController.addListener(_checkBoardNameExists);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    columnCountController.dispose();
  }

  Future<bool> boardNameExists(String name) async {
    final boardManager = ref.read(boardManagerProvider);
    final existingBoard = await boardManager.findBoardByName(name);
    return existingBoard != null;
  }
  
  Future<void> _checkBoardNameExists() async {
    final name = nameController.text;
    
    if (name != widget.params.name) {
      final exists = await boardNameExists(name);
      setState(() {
        _isNameUnique = !exists;
      });
    } else {
      setState(() {
        _isNameUnique = true;
      });
    }
  }

  String? validateBoardName(String? val) {
    if (val == null || val.isEmpty) {
      return "Nazwa nie może być pusta";
    }
    if (!_isNameUnique) {
      return "Tablica o takiej nazwie już istnieje";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.5),
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 29.0, vertical: 27.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GenericTextField(
                      controller: nameController,
                      labelText: "Nazwa",
                      validator: validateBoardName,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GenericNumberField(
                          name: "dupa",
                          controller: columnCountController,
                          inputFormatters: [positiveDigitsOnly],
                          validator: (val) {
                            if (val != null && val.startsWith("0")) {
                              return "Liczba kolumn powinna być większa od 0";
                            }
                            return null;
                          },
                          labelText: "Liczba Kolumn",
                        )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 28.0,),
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
                          if (!_formKey.currentState!.validate()) return;
                          Navigator.pop(
                              context,
                              widget.params.copyWith(
                                name: nameController.text,
                                id: widget.params.id,
                                columnCount:
                                    int.tryParse(columnCountController.text),
                              ));
                        },
                        child: const Text("Zapisz"))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
