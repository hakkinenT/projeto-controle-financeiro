import '../../../utils/utils.dart';
import '../../../validator/validator.dart';

class DescriptionInput implements ValidFormInput {
  final String description;

  DescriptionInput({required this.description});

  final RegExp _regExp = RegExp(kRegexInputText);

  @override
  bool get isInvalid => _regExp.hasMatch(description) == false;

  @override
  bool get isValid => _regExp.hasMatch(description) == false;

  @override
  String? get onError {
    if (isInvalid) {
      return 'Informe a descrição';
    } else {
      return null;
    }
  }
}
