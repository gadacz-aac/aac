import 'package:flutter/material.dart';

class AacSearchField extends StatefulWidget {
  final String placeholder;

  final Widget? icon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onClick;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  const AacSearchField(
      {super.key,
      required this.placeholder,
      this.icon,
      this.readOnly = false,
      this.suffixIcon,
      this.controller,
      this.onClick,
      this.onChanged,
      this.errorText,
      this.validator});

  @override
  State<AacSearchField> createState() => _AacSearchFieldState();
}

class _AacSearchFieldState extends State<AacSearchField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  void clearOrPop() {
    final controller = widget.controller;

    if (controller == null) {
      return;
    }

    if (controller.text.isEmpty) {
      Navigator.pop(context);
      return;
    }

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    var suffixIcon = widget.suffixIcon;

    if (suffixIcon == null && widget.controller != null) {
      suffixIcon =
          IconButton(onPressed: clearOrPop, icon: const Icon(Icons.cancel));
    }

    return TextFormField(
      readOnly: widget.readOnly,
      focusNode: focusNode,
      style: const TextStyle(fontSize: 16),
      onTap: widget.onClick,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF4F2F2),
        filled: true,
        hintText: widget.placeholder,
        prefixIcon: widget.icon ?? const Icon(Icons.search),
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        errorText: widget.errorText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide.none),
      ),
    );
  }
}
