class FormControl<T> {
  T value;
  List<FormValidator> validators;

  FormControl({required this.value, List<FormValidator>? validators})
      : validators = validators ?? [];
}

class FormValidator<T> {
  bool Function(T? val) validator;
  String errorMessage;

  String? validate(T? val) => this.validator(val) ? errorMessage : null;

  FormValidator({required this.validator, required this.errorMessage});
}

final required = FormValidator(
    validator: (val) => switch (val) {
          null => true,
          String s => s.trim().isEmpty,
          _ => false,
        },
    errorMessage: "Wartość jest wymagana");
