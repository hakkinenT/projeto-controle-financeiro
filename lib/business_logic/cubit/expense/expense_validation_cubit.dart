import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/form_models/form_models.dart';

import '../../../validator/validator.dart';

part 'expense_validation_state.dart';

class ExpenseValidationCubit extends Cubit<ExpenseValidationState> {
  ExpenseValidationCubit() : super(const ExpenseValidating());

  void validateIncomeForm(Map<String, String?> formData) {
    String description = formData['description']!;
    String value = formData['value']!;
    String? type = formData['type'];
    String? classification = formData['classification'];

    final descriptionInput = DescriptionInput(description: description);
    final valueInput = ValueInput(value: value);
    final typeInput = TypeInput(type: type);
    final classificationInput =
        ClassificationInput(classification: classification);

    final validFormInputs = <ValidFormInput>[
      descriptionInput,
      valueInput,
      typeInput,
      classificationInput
    ];

    final validForm = ValidForm(validFormInputs: validFormInputs);

    if (validForm.isValidate) {
      emit(const ExpenseValidated());
    } else {
      emit(ExpenseValidating(
          descriptionInput: descriptionInput,
          valueInput: valueInput,
          typeInput: typeInput,
          classificationInput: classificationInput));
    }
  }
}
