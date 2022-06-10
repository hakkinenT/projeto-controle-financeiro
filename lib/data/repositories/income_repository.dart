import '../models/models.dart';
import 'repositories.dart';
import '../data_providers/data_providers.dart';

class IncomeRepository implements IIncomeRepository {
  final _incomeApi = IncomeAPI();

  @override
  Future<bool> addIncome(
      {required Income income, required String userId}) async {
    try {
      await _incomeApi.createIncome(income: income, userId: userId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteIncome({required String incomeId}) async {
    try {
      await _incomeApi.deleteIncome(incomeId: incomeId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<Income>> getAllIncomes() {
    return _incomeApi.readIncomes();
  }

  @override
  Future<bool> updateIncome({required Income income}) async {
    try {
      _incomeApi.updateIncome(income: income);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
