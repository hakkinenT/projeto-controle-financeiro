import 'package:formz/formz.dart';

enum DescriptionValidationError { empty }

class Description extends FormzInput<String, DescriptionValidationError> {
  Description.pure() : super.pure('');
  Description.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String value) {
    return value.isNotEmpty ? null : DescriptionValidationError.empty;
  }
}
