part of 'expense_validation_cubit.dart';

abstract class ExpenseValidationState extends Equatable {
  const ExpenseValidationState();

  @override
  List<Object?> get props => [];
}

class ExpenseValidating extends ExpenseValidationState {
  const ExpenseValidating({
    this.descriptionInput,
    this.valueInput,
    this.typeInput,
    this.classificationInput,
  });

  final DescriptionInput? descriptionInput;
  final ValueInput? valueInput;
  final TypeInput? typeInput;
  final ClassificationInput? classificationInput;

  ExpenseValidating copyWith({
    DescriptionInput? descriptionInput,
    ValueInput? valueInput,
    TypeInput? typeInput,
    ClassificationInput? classificationInput,
  }) {
    return ExpenseValidating(
      descriptionInput: descriptionInput ?? this.descriptionInput,
      valueInput: valueInput ?? this.valueInput,
      typeInput: typeInput ?? this.typeInput,
      classificationInput: classificationInput ?? this.classificationInput,
    );
  }

  @override
  List<Object?> get props =>
      [descriptionInput, valueInput, typeInput, classificationInput];
}

class ExpenseValidated extends ExpenseValidationState {
  const ExpenseValidated();
}
