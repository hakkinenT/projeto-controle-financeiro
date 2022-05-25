import 'package:formz/formz.dart';

enum NameInputError { empty, invalid }

class Name extends FormzInput<String, NameInputError> {
  const Name.pure() : super.pure('');

  const Name.dirty({String value = ''}) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(r'^(?=.*[a-z])[A-Za-z ]{2,}$');

  @override
  NameInputError? validator(String? value) {
    if (value?.isNotEmpty == false) {
      return NameInputError.empty;
    }
    return _nameRegExp.hasMatch(value!) ? null : NameInputError.invalid;
  }
}
