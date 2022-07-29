import 'package:projeto_controle_financeiro/form_validator/validator.dart';

import '../../../../utils/utils.dart';

class DescriptionInput implements FormInputValidator {
  final String value;

  DescriptionInput({required this.value});

  final RegExp _regExp = RegExp(kRegexInputText);

  @override
  bool get invalid => _regExp.hasMatch(value) == false;

  @override
  bool get valid => _regExp.hasMatch(value) == true;

  @override
  String? get onError {
    if (invalid) {
      return 'Informe a descrição';
    } else {
      return null;
    }
  }
}
