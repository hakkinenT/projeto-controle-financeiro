import 'package:formz/formz.dart';

enum ValueValidationError { zero }

class Value extends FormzInput<int, ValueValidationError> {
  Value.pure() : super.pure(0);
  Value.dirty([int value = 0]) : super.dirty(value);

  @override
  ValueValidationError? validator(int value) {
    return value > 0 ? null : ValueValidationError.zero;
  }
}
