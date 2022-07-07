import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../validator/validator.dart';
import '../../../data/form_models/form_models.dart';
part 'income_validation_state.dart';

class IncomeValidationCubit extends Cubit<IncomeValidationState> {
  IncomeValidationCubit() : super(const IncomeValidating());

  void validateIncomeForm(Map<String, String?> formData) {
    String description = formData['description']!;
    String value = formData['value']!;
    String? type = formData['type'];

    final descriptionInput = DescriptionInput(description: description);
    final valueInput = ValueInput(value: value);
    final typeInput = TypeInput(type: type);

    final validFormInputs = <ValidFormInput>[
      descriptionInput,
      valueInput,
      typeInput
    ];

    final validForm = ValidForm(validFormInputs: validFormInputs);

    if (validForm.isValidate) {
      emit(const IncomeValidated());
    } else {
      emit(IncomeValidating(
          descriptionInput: descriptionInput,
          valueInput: valueInput,
          typeInput: typeInput));
    }
  }
}
