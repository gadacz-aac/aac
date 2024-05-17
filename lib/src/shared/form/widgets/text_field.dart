import 'package:flutter/material.dart';

//Jest tu kto? Jeśli tak, to niech się wpisze na listę gości, ja zacznę
//Wiktor i Piotrek 17.05.2024 zakładamy że nie będzie tu po co zaglądać

//Licznik zaoszczędzonych linijek:
//15 /features/symbols/symbol_settings

class GenericTextField extends StatefulWidget {
  const GenericTextField(
      {super.key,
      this.onChanged,
      this.validator,
      required this.labelText,
      this.helperText,
      this.initalValue});

  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String labelText;
  final String? initalValue;
  final String? helperText;
  @override
  State<GenericTextField> createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      autocorrect: true,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
      ),
      initialValue: widget.initalValue,
    );
  }
}
