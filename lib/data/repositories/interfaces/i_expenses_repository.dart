import '../../models/models.dart';

abstract class IExpenseRepository {
  Future<bool> addExpense({required Expense expense, required String userId});
  Future<List<Expense>> getAllExpense();
  Future<bool> updateExpense({required Expense expense});
  Future<bool> deleteExpense({required String expenseId});
}
