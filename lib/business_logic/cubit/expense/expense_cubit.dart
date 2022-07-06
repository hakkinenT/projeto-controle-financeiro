import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projeto_controle_financeiro/dependency_injection/dependency_injection.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit({required IExpenseRepository expenseRepository})
      : _expenseRepository = expenseRepository,
        super(ExpenseInitial());

  final IExpenseRepository _expenseRepository;

  Future saveExpense(Expense expense) async {
    emit(ExpenseLoading());
    try {
      final user = getIt<AuthenticationRepository>();
      final userId = user.currentUser.id;

      if (expense.id == null) {
        await _expenseRepository.addExpense(expense: expense, userId: userId);
      } else {
        await _expenseRepository.updateExpense(expense: expense);
      }
      emit(ExpenseSuccess());
    } on Exception {
      emit(const ExpenseFailure(
          message: 'Houve um erro ao tentar cadastrar a Despesa'));
    }
  }

  Future<void> getAllExpenses() async {
    emit(ExpenseLoading());
    try {
      final expenses = await _expenseRepository.getAllExpense();
      emit(ExpenseLoaded(expenses: expenses));
    } on Exception {
      emit(const ExpenseFailure(
          message: 'Houve um erro ao tentar carregar as despesas'));
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    emit(ExpenseLoading());
    try {
      await _expenseRepository.deleteExpense(expenseId: expenseId);
      emit(ExpenseSuccess());
    } on Exception {
      emit(const ExpenseFailure(
          message: 'Houve um erro ao tentar excluir a Despesa'));
    }
  }
}
