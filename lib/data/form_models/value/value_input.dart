import '../../../utils/utils.dart';
import '../../../validator/validator.dart';

class ValueInput implements ValidFormInput {
  final String value;

  ValueInput({required this.value});

  final RegExp _regExp = RegExp(kRegexNumberInput);

  @override
  bool get isInvalid => _regExp.hasMatch(value) == false;

  @override
  bool get isValid => _regExp.hasMatch(value) == true;

  @override
  String? get onError {
    if (isInvalid) {
      return 'Informe um valor maior que 0';
    } else {
      return null;
    }
  }
}
