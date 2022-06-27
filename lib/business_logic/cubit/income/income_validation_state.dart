part of 'income_validation_cubit.dart';

abstract class IncomeValidationState extends Equatable {
  const IncomeValidationState();

  @override
  List<Object?> get props => [];
}

class IncomeValidating extends IncomeValidationState {
  const IncomeValidating(
      {this.descriptionInput, this.valueInput, this.typeInput});

  final DescriptionInput? descriptionInput;
  final ValueInput? valueInput;
  final TypeInput? typeInput;

  IncomeValidating copyWith(
      {DescriptionInput? descriptionInput,
      ValueInput? valueInput,
      TypeInput? typeInput}) {
    return IncomeValidating(
        descriptionInput: descriptionInput ?? this.descriptionInput,
        valueInput: valueInput ?? this.valueInput,
        typeInput: typeInput ?? this.typeInput);
  }

  @override
  List<Object?> get props => [descriptionInput, valueInput, typeInput];
}

class IncomeValidated extends IncomeValidationState {
  const IncomeValidated();
}
