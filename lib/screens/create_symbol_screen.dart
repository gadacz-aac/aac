import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSymbolMenu extends StatefulWidget {
  const AddSymbolMenu({super.key});

  @override
  State<AddSymbolMenu> createState() => _AddSymbolMenuState();
}

class _AddSymbolMenuState extends State<AddSymbolMenu> {
  String _imagePath = "";

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
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
          //https://stackoverflow.com/questions/61721809/flutter-call-navigator-pop-inside-async-function
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

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Code for adding new symbol
                  List<String> result = [];
                  result.add(_imagePath);
                  result.add(_controller.text);
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
