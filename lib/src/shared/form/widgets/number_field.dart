import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenericNumberField extends StatelessWidget {
  const GenericNumberField(
      {super.key,
      required this.name,
      this.onChanged,
      this.validator,
      this.controller,
      required this.labelText,
      this.helperText,
      this.initalValue = 0,
      this.enabled});

  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String name;
  final String labelText;
  final bool? enabled;
  final int initalValue;
  final TextEditingController? controller;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    if (int.tryParse(controller?.text ?? "") == null) controller?.text = "0";
    return TextFormField(
      initialValue: controller == null ? "$initalValue" : null,
      autocorrect: true,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
