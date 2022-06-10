import '../models/models.dart';
import 'repositories.dart';
import '../data_providers/data_providers.dart';

class ExpenseRepository implements IExpenseRepository {
  final _expenseApi = ExpenseAPI();
  @override
  Future<bool> addExpense(
      {required Expense expense, required String userId}) async {
    try {
      await _expenseApi.createExpense(expense: expense, userId: userId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteExpense({required String expenseId}) async {
    try {
      await _expenseApi.deleteExpense(expenseId: expenseId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<Expense>> getAllExpense() {
    return _expenseApi.readExpense();
  }

  @override
  Future<bool> updateExpense({required Expense expense}) async {
    try {
      await _expenseApi.updateExpense(expense: expense);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
