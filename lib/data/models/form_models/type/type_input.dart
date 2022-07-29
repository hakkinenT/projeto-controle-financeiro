import 'package:projeto_controle_financeiro/form_validator/validator.dart';

class TypeInput implements FormInputValidator {
  final String? value;
  TypeInput({required this.value});

  @override
  bool get invalid => value == null;

  @override
  bool get valid => value != null;

  @override
  String? get onError {
    if (invalid) {
      return 'Selecione um tipo';
    } else {
      return null;
    }
  }
}
