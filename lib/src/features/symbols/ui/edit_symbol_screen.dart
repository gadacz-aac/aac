import 'package:aac/src/features/boards/model/board.dart';
import 'package:aac/src/features/symbols/model/communication_symbol.dart';
import 'package:aac/src/features/symbols/symbol_manager.dart';
import 'package:aac/src/features/symbols/ui/symbol_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditSymbolScreen extends ConsumerStatefulWidget {
  const EditSymbolScreen(
      {super.key, required this.symbol, required this.board});

  final CommunicationSymbol symbol;
  final Board board;

  @override
  ConsumerState<EditSymbolScreen> createState() => _EditSymbolScreenState();
}

class _EditSymbolScreenState extends ConsumerState<EditSymbolScreen> {
  late String _imagePath;
  late bool _isLink;
  late TextEditingController _controller;
  late TextEditingController _crossAxisCountController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.symbol.label);
    _crossAxisCountController = TextEditingController(
        text: widget.symbol.childBoard.value?.crossAxisCount.toString() ?? "2");
    _imagePath = widget.symbol.imagePath;
    _isLink = widget.symbol.childBoard.value != null;
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
      widget.symbol.label = _controller.text;
      widget.symbol.imagePath = _imagePath;

      manager.updateSymbol(
          symbol: widget.symbol,
          parentBoard: widget.board,
          crossAxisCount: int.tryParse(_crossAxisCountController.text),
          createChild: _isLink);
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SymbolImage(_imagePath),
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

                    if (imageFile != null) {
                      setState(() {
                        _imagePath = imageFile.path;
                      });
                    }
                  },
                  child: const Text('Select image'), // Pass it in Navigator.pop
                ),
                SwitchListTile(
                  title: const Text('Link to a child board'),
                  value: _isLink,
                  onChanged: (bool value) {
                    setState(() {
                      _isLink = value;
                    });
                  },
                ),
                if (_isLink)
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a number';
                      }
                      if (int.tryParse(value)! <= 0) {
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
            ),
          ),
        ));
  }
}
