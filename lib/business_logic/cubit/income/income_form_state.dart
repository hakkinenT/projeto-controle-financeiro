part of 'income_form_cubit.dart';

class IncomeFormState extends Equatable {
  const IncomeFormState(
      {this.descriptionInput,
      this.valueInput,
      this.typeInput,
      this.status,
      this.descriptionIsNotValidated = false,
      this.typeIsNotValidated = false,
      this.valueIsNotValidated = false,
      required this.descriptionFocusNode,
      required this.valueFocusNode,
      required this.typeFocusNode});

  final DescriptionInput? descriptionInput;
  final ValueInput? valueInput;
  final TypeInput? typeInput;
  final FormStatus? status;
  final bool? descriptionIsNotValidated;
  final bool? typeIsNotValidated;
  final bool? valueIsNotValidated;

  final FocusNode descriptionFocusNode;
  final FocusNode valueFocusNode;
  final FocusNode typeFocusNode;

  @override
  List<Object?> get props => [
        descriptionInput,
        valueInput,
        typeInput,
        status,
        descriptionIsNotValidated,
        valueIsNotValidated,
        typeIsNotValidated,
        descriptionFocusNode,
        valueIsNotValidated,
        typeIsNotValidated,
      ];

  IncomeFormState copyWith({
    DescriptionInput? descriptionInput,
    ValueInput? valueInput,
    TypeInput? typeInput,
    FormStatus? status,
    bool? descriptionIsNotValidated,
    bool? typeIsNotValidated,
    bool? valueIsNotValidated,
    FocusNode? descriptionFocusNode,
    FocusNode? valueFocusNode,
    FocusNode? typeFocusNode,
  }) {
    return IncomeFormState(
        descriptionInput: descriptionInput ?? this.descriptionInput,
        valueInput: valueInput ?? this.valueInput,
        typeInput: typeInput ?? this.typeInput,
        status: status ?? this.status,
        descriptionIsNotValidated:
            descriptionIsNotValidated ?? this.descriptionIsNotValidated,
        valueIsNotValidated: valueIsNotValidated ?? this.valueIsNotValidated,
        typeIsNotValidated: typeIsNotValidated ?? this.typeIsNotValidated,
        descriptionFocusNode: descriptionFocusNode ?? this.descriptionFocusNode,
        valueFocusNode: valueFocusNode ?? this.valueFocusNode,
        typeFocusNode: typeFocusNode ?? this.typeFocusNode);
  }
}
