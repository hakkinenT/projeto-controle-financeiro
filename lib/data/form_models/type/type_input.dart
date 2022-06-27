import '../../../validator/validator.dart';

class TypeInput implements ValidFormInput {
  final String? type;
  TypeInput({required this.type});

  @override
  bool get isInvalid => type == null;

  @override
  bool get isValid => type != null;

  @override
  String? get onError {
    if (isInvalid) {
      return 'Selecione um tipo';
    } else {
      return null;
    }
  }
}
