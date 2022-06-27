import 'valid_form_field.dart';

class ValidForm {
  final List<ValidFormInput> validFormInputs;

  ValidForm({required this.validFormInputs});

  bool get isValidate {
    bool isValidate = true;

    for (var input in validFormInputs) {
      if (input.isInvalid) {
        isValidate = false;
        return isValidate;
      }
    }
    return isValidate;
  }
}
