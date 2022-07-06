import 'package:projeto_controle_financeiro/validator/validator.dart';

class ClassificationInput implements ValidFormInput {
  final String? classification;
  ClassificationInput({required this.classification});

  @override
  bool get isInvalid => classification == null;

  @override
  bool get isValid => classification != null;

  @override
  String? get onError {
    if (isInvalid) {
      return 'Selecione uma classificação';
    } else {
      return null;
    }
  }
}
