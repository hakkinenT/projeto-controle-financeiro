import '../../models/models.dart';

abstract class IIncomeRepository {
  Future<bool> addIncome({required Income income, required String userId});
  Stream<List<Income>> getAllIncomes();
  Future<bool> updateIncome({required Income income});
  Future<bool> deleteIncome({required String incomeId});
}