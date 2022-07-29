import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projeto_controle_financeiro/data/models/form_models/form_models.dart';
import 'package:projeto_controle_financeiro/utils/enum_map.dart';

import '../../../data/models/models.dart';
import '../../../form_validator/validator.dart';

part 'income_form_state.dart';

class IncomeFormCubit extends Cubit<IncomeFormState> {
  IncomeFormCubit()
      : super(IncomeFormState(
            descriptionInput: DescriptionInput(value: ''),
            valueInput: ValueInput(value: ''),
            typeInput: TypeInput(value: null),
            descriptionFocusNode: FocusNode(),
            valueFocusNode: FocusNode(),
            typeFocusNode: FocusNode()));

  void descriptionChanged(String description) {
    final descriptionInput = DescriptionInput(value: description);

    emit(state.copyWith(
        descriptionInput: descriptionInput,
        status: FormValidator.validate(
            inputs: [descriptionInput, state.valueInput, state.typeInput])));
  }

  void valueChanged(String value) {
    final valueInput = ValueInput(value: value);

    emit(state.copyWith(
        valueInput: valueInput,
        status: FormValidator.validate(
            inputs: [state.descriptionInput, valueInput, state.typeInput])));
  }

  void typeChanged(String? type) {
    final typeInput = TypeInput(value: type);

    emit(state.copyWith(
        typeInput: typeInput,
        status: FormValidator.validate(
            inputs: [state.descriptionInput, state.valueInput, typeInput])));
  }

  void _descriptionValidated() {
    if (!state.descriptionFocusNode.hasFocus) {
      if (state.descriptionInput!.invalid) {
        emit(state.copyWith(descriptionIsNotValidated: true));
      } else {
        emit(state.copyWith(descriptionIsNotValidated: false));
      }
    }
  }

  void _valueValidated() {
    if (!state.valueFocusNode.hasFocus) {
      if (state.valueInput!.invalid) {
        emit(state.copyWith(valueIsNotValidated: true));
      } else {
        emit(state.copyWith(valueIsNotValidated: false));
      }
    }
  }

  void _typeValidated() {
    if (state.typeFocusNode.hasFocus) {
      if (state.typeInput!.invalid) {
        emit(state.copyWith(typeIsNotValidated: true));
      } else {
        emit(state.copyWith(typeIsNotValidated: false));
      }
    }
  }

  void _descriptionListener() {
    state.descriptionFocusNode.addListener(() {
      _descriptionValidated();
    });
  }

  void _valueListener() {
    state.valueFocusNode.addListener(() {
      _valueValidated();
    });
  }

  void _typeListener() {
    state.typeFocusNode.addListener(() {
      _typeValidated();
    });
  }

  void formInputsListeners() {
    _descriptionListener();
    _valueListener();
    _typeListener();
  }

  void updateInputs(Income income) {
    final descriptionInput = DescriptionInput(value: income.description);
    final valueInput = ValueInput(value: income.value.toString());
    final typeInput = TypeInput(value: typeEnumMap[income.type]);

    emit(state.copyWith(
        descriptionInput: descriptionInput,
        valueInput: valueInput,
        typeInput: typeInput,
        status: FormValidator.validate(
            inputs: [descriptionInput, valueInput, typeInput])));
  }

  _removeListeners() {
    state.descriptionFocusNode.removeListener(() {});
    state.valueFocusNode.removeListener(() {});
    state.typeFocusNode.removeListener(() {});
  }

  _disposeNodes() {
    state.descriptionFocusNode.dispose();
    state.valueFocusNode.dispose();
    state.typeFocusNode.dispose();
  }

  @override
  Future<void> close() {
    _removeListeners();
    _disposeNodes();
    return super.close();
  }
}
