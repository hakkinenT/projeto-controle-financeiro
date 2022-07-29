import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/form_models/form_models.dart';
import '../../../data/models/models.dart';
import '../../../form_validator/validator.dart';
import '../../../utils/utils.dart';

part 'expense_form_state.dart';

class ExpenseFormCubit extends Cubit<ExpenseFormState> {
  ExpenseFormCubit()
      : super(ExpenseFormState(
            descriptionInput: DescriptionInput(value: ''),
            valueInput: ValueInput(value: ''),
            typeInput: TypeInput(value: null),
            classificationInput: ClassificationInput(value: null),
            expirationDateInput: null,
            descriptionFocusNode: FocusNode(),
            valueFocusNode: FocusNode(),
            typeFocusNode: FocusNode(),
            classificationFocusNode: FocusNode(),
            expirationDateFocusNode: FocusNode()));

  void descriptionChanged(String description) {
    final descriptionInput = DescriptionInput(value: description);
    emit(state.copyWith(
        descriptionInput: descriptionInput,
        status: FormValidator.validate(inputs: [
          descriptionInput,
          state.valueInput,
          state.typeInput,
          state.classificationInput
        ])));
  }

  void valueChanged(String value) {
    final valueInput = ValueInput(value: value);
    emit(state.copyWith(
        valueInput: valueInput,
        status: FormValidator.validate(inputs: [
          state.descriptionInput,
          valueInput,
          state.typeInput,
          state.classificationInput
        ])));
  }

  void typeChanged(String? type) {
    final typeInput = TypeInput(value: type);
    emit(state.copyWith(
        typeInput: typeInput,
        status: FormValidator.validate(inputs: [
          state.descriptionInput,
          state.valueInput,
          typeInput,
          state.classificationInput
        ])));
  }

  void classificationChanged(String? classification) {
    final classificationInput = ClassificationInput(value: classification);
    emit(state.copyWith(
        classificationInput: classificationInput,
        status: FormValidator.validate(inputs: [
          state.descriptionInput,
          state.valueInput,
          state.typeInput,
          classificationInput
        ])));
  }

  void setExpirationDate(String expirationDate) {
    emit(state.copyWith(
        expirationDateInput: TextEditingController(text: expirationDate)));
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

  void _classificationValidated() {
    if (state.classificationFocusNode.hasFocus) {
      if (state.classificationInput!.invalid) {
        emit(state.copyWith(classificationIsNotValidated: true));
      } else {
        emit(state.copyWith(classificationIsNotValidated: false));
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

  void _classificationListener() {
    state.classificationFocusNode.addListener(() {
      _classificationValidated();
    });
  }

  void formInputsListeners() {
    _descriptionListener();
    _valueListener();
    _typeListener();
    _classificationListener();
  }

  void changeExpirationDateFocus() {
    state.expirationDateFocusNode.requestFocus();
  }

  void updateInputs(Expense expense) {
    final descriptionInput = DescriptionInput(value: expense.description);
    final valueInput = ValueInput(value: expense.value.toString());
    final typeInput = TypeInput(value: typeEnumMap[expense.type]);
    final classificationInput = ClassificationInput(
        value: classificationEnumMap[expense.classification]);
    final expirationDateInput = expense.expirationDate == null
        ? TextEditingController(text: "")
        : TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(expense.expirationDate!));

    emit(state.copyWith(
        descriptionInput: descriptionInput,
        valueInput: valueInput,
        typeInput: typeInput,
        classificationInput: classificationInput,
        expirationDateInput: expirationDateInput,
        status: FormValidator.validate(
            inputs: [descriptionInput, valueInput, typeInput])));
  }

  _removeListeners() {
    state.descriptionFocusNode.removeListener(() {});
    state.valueFocusNode.removeListener(() {});
    state.typeFocusNode.removeListener(() {});
    state.classificationFocusNode.removeListener(() {});
  }

  _disposeNodes() {
    state.descriptionFocusNode.dispose();
    state.valueFocusNode.dispose();
    state.typeFocusNode.dispose();
    state.classificationFocusNode.dispose();
    state.expirationDateFocusNode.dispose();
  }

  @override
  Future<void> close() {
    _removeListeners();
    _disposeNodes();
    state.expirationDateInput?.dispose();
    return super.close();
  }
}
