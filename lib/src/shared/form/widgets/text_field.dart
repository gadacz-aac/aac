import 'package:flutter/material.dart';

//Jest tu kto? Jeśli tak, to niech się wpisze na listę gości, ja zacznę
//Wiktor i Piotrek 17.05.2024 zakładamy że nie będzie tu po co zaglądać

//Licznik zaoszczędzonych linijek:
//15 /features/symbols/symbol_settings

class GenericTextField extends StatelessWidget {
  const GenericTextField(
      {super.key,
      this.onChanged,
      this.controller,
      this.validator,
      required this.labelText,
      this.helperText,
      this.initalValue});

  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String labelText;
  final String? initalValue;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: controller == null ? initalValue : null,
      autocorrect: true,
      controller: controller,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
