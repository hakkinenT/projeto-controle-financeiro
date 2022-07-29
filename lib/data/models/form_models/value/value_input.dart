import 'package:projeto_controle_financeiro/form_validator/validator.dart';

import '../../../../utils/utils.dart';

class ValueInput implements FormInputValidator {
  final String value;

  ValueInput({required this.value});

  final RegExp _regExp = RegExp(kRegexNumberInput);

  @override
  bool get invalid => _regExp.hasMatch(value) == false;

  @override
  bool get valid => _regExp.hasMatch(value) == true;

  @override
  String? get onError {
    if (invalid) {
      return 'Informe um valor maior que 0';
    } else {
      return null;
    }
  }
}
