part of 'expense_form_cubit.dart';

class ExpenseFormState extends Equatable {
  const ExpenseFormState(
      {this.descriptionInput,
      this.valueInput,
      this.typeInput,
      this.classificationInput,
      this.expirationDateInput,
      this.status,
      this.descriptionIsNotValidated = false,
      this.typeIsNotValidated = false,
      this.valueIsNotValidated = false,
      this.classificationIsNotValidated = false,
      required this.descriptionFocusNode,
      required this.valueFocusNode,
      required this.typeFocusNode,
      required this.classificationFocusNode,
      required this.expirationDateFocusNode});

  final DescriptionInput? descriptionInput;
  final ValueInput? valueInput;
  final TypeInput? typeInput;
  final ClassificationInput? classificationInput;
  final TextEditingController? expirationDateInput;
  final FormStatus? status;
  final bool? descriptionIsNotValidated;
  final bool? typeIsNotValidated;
  final bool? valueIsNotValidated;
  final bool? classificationIsNotValidated;
  final FocusNode descriptionFocusNode;
  final FocusNode valueFocusNode;
  final FocusNode typeFocusNode;
  final FocusNode classificationFocusNode;
  final FocusNode expirationDateFocusNode;

  @override
  List<Object?> get props => [
        descriptionInput,
        valueInput,
        typeInput,
        status,
        classificationInput,
        expirationDateInput,
        descriptionIsNotValidated,
        valueIsNotValidated,
        typeIsNotValidated,
        descriptionFocusNode,
        expirationDateFocusNode,
        classificationFocusNode,
        valueIsNotValidated,
        typeIsNotValidated,
        classificationIsNotValidated
      ];

  ExpenseFormState copyWith(
      {DescriptionInput? descriptionInput,
      ValueInput? valueInput,
      TypeInput? typeInput,
      ClassificationInput? classificationInput,
      TextEditingController? expirationDateInput,
      FormStatus? status,
      bool? descriptionIsNotValidated,
      bool? typeIsNotValidated,
      bool? valueIsNotValidated,
      bool? classificationIsNotValidated,
      FocusNode? descriptionFocusNode,
      FocusNode? valueFocusNode,
      FocusNode? typeFocusNode,
      FocusNode? classificationFocusNode,
      FocusNode? expirationDateFocusNode}) {
    return ExpenseFormState(
        descriptionInput: descriptionInput ?? this.descriptionInput,
        valueInput: valueInput ?? this.valueInput,
        typeInput: typeInput ?? this.typeInput,
        status: status ?? this.status,
        classificationInput: classificationInput ?? this.classificationInput,
        expirationDateInput: expirationDateInput ?? this.expirationDateInput,
        descriptionIsNotValidated:
            descriptionIsNotValidated ?? this.descriptionIsNotValidated,
        valueIsNotValidated: valueIsNotValidated ?? this.valueIsNotValidated,
        classificationIsNotValidated:
            classificationIsNotValidated ?? this.classificationIsNotValidated,
        typeIsNotValidated: typeIsNotValidated ?? this.typeIsNotValidated,
        descriptionFocusNode: descriptionFocusNode ?? this.descriptionFocusNode,
        valueFocusNode: valueFocusNode ?? this.valueFocusNode,
        typeFocusNode: typeFocusNode ?? this.typeFocusNode,
        expirationDateFocusNode:
            expirationDateFocusNode ?? this.expirationDateFocusNode,
        classificationFocusNode:
            classificationFocusNode ?? this.classificationFocusNode);
  }
}
