import 'package:projeto_controle_financeiro/form_validator/validator.dart';

class ClassificationInput implements FormInputValidator {
  final String? value;
  ClassificationInput({required this.value});

  @override
  bool get invalid => value == null;

  @override
  String? get onError {
    if (invalid) {
      return 'Selecione uma classificação';
    } else {
      return null;
    }
  }

  @override
  bool get valid => value != null;
}
