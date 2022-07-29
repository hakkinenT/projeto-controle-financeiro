import 'form_input_validator.dart';

enum FormStatus { pure, validated, invalid }

class FormValidator {
  FormValidator();
  static FormStatus validate({required List<FormInputValidator?> inputs}) {
    final isValidate = inputs.every((input) => input?.invalid == false);

    if (isValidate) {
      return FormStatus.validated;
    } else {
      return FormStatus.invalid;
    }
  }
}
