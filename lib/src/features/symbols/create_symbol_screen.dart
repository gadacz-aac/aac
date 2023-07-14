import 'package:aac/src/features/symbols/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';

class AddSymbolMenu extends ConsumerStatefulWidget {
  const AddSymbolMenu({super.key, required this.boardId});

  final Id boardId;

  @override
  ConsumerState<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends ConsumerState<AddSymbolMenu> {
  String _imagePath = "";

  late TextEditingController _controller;
  late TextEditingController _crossAxisCountController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _crossAxisCountController = TextEditingController(text: "2");
  }

  @override
  void dispose() {
    _controller.dispose();
    _crossAxisCountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _imagePath = _imagePath == ""
          ? "https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png"
          : _imagePath;
      final manager = ref.read(symbolManagerProvider);
      manager.saveSymbol(widget.boardId,
          label: _controller.text,
          imagePath: _imagePath,
          crossAxisCount: _crossAxisCountController.text);
      if (context.mounted) {
        Navigator.pop(context); // Return nothing
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new symbol'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
              child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Symbol's name", // Pass it in Navigator.pop
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final imageFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  String defaultImage =
                      'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

                  _imagePath =
                      imageFile != null ? imageFile.path : defaultImage;
                },
                child: const Text('Select image'), // Pass it in Navigator.pop
              ),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a number';
                  }
                  if (int.tryParse(value)! <= 0) {
                    // TODO: Można dodać obsługę tekstu, albo coś jeszcze
                    return 'The width must be higher than 0';
                  }
                  return null;
                },
                controller: _crossAxisCountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Apply'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Return nothing
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          )),
        ));
  }
}
