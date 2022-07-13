import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_interaction_state.dart';

class AppInteractionCubit extends Cubit<AppInteractionState> {
  AppInteractionCubit() : super(const AppInteractionState());

  // Por algum motivo, só foi possível obter o indice atual da page
  // criando um método que retorna o estado referente a ele
  int get pageIndex => state.pageFilterChanged;

  void expandIconButtonPressed(bool expandedIconPressed) {
    if (expandedIconPressed) {
      emit(state.copyWith(showInformationPanel: false));
    } else {
      emit(state.copyWith(showInformationPanel: true));
    }
  }

  void typeButtonPressed() {
    if (state.isTypeButton) {
      emit(state.copyWith(isTypeButton: false));
    } else {
      emit(state.copyWith(isTypeButton: true));
    }
  }

  void incomeFilterChipSelected(bool incomeSelected) {
    if (incomeSelected) {
      emit(state.copyWith(
          isIncomeFilterSelected: incomeSelected,
          isExpenseFilterSelected: false,
          pageFilterChanged: state.pageFilterChanged - 1));
    } else if (incomeSelected == false &&
        state.isExpenseFilterSelected == false) {
      emit(state.copyWith(isIncomeFilterSelected: true));
    }
  }

  void expenseFilterChipSelected(bool expenseSelected) {
    if (expenseSelected) {
      emit(state.copyWith(
          isIncomeFilterSelected: false,
          isExpenseFilterSelected: expenseSelected,
          pageFilterChanged: state.pageFilterChanged + 1));
    } else if (expenseSelected == false &&
        state.isExpenseFilterSelected == false) {
      emit(state.copyWith(isExpenseFilterSelected: true));
    }
  }

  void pageFilterChipChanged(int index) {
    if (index == 0) {
      emit(state.copyWith(
          isExpenseFilterSelected: false,
          isIncomeFilterSelected: true,
          pageFilterChanged: index));
    } else {
      emit(state.copyWith(
          isExpenseFilterSelected: true,
          isIncomeFilterSelected: false,
          pageFilterChanged: index));
    }
  }

  void showWidgetOnScroll() {
    if (!state.isPageScroll) {
      emit(state.copyWith(isPageScroll: true));
    }
  }

  void hideWidgetOnScroll() {
    if (state.isPageScroll) {
      emit(state.copyWith(isPageScroll: false));
    }
  }
}
