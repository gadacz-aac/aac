import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddSymbolMenu extends StatefulWidget {
  const AddSymbolMenu({super.key});

  @override
  State<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends State<AddSymbolMenu> {
  String _imagePath = "";

  late TextEditingController _controller;
  late TextEditingController _crossAxisCountController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _crossAxisCountController = TextEditingController(text: "2");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new symbol'),
      ),
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Symbol's name", // Pass it in Navigator.pop
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final imageFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              String defaultImage =
                  'https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png';

              _imagePath = imageFile != null ? imageFile.path : defaultImage;
            },
            child: const Text('Select image'), // Pass it in Navigator.pop
          ),
          TextField(
            controller: _crossAxisCountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Code for adding new symbol
                  List<String> result = [];
                  result.add(_imagePath == ""
                      ? "https://cdn.discordapp.com/attachments/1108422948970319886/1113420050058203256/image.png"
                      : _imagePath);
                  result.add(_controller.text);
                  result.add(_crossAxisCountController.text);
                  Navigator.pop(context,
                      result); // Return data used for creating new Symbol
                },
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
    );
  }
}
