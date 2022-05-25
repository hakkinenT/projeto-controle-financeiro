import '../dao/dao.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class IncomeServices implements DataRepositoryWithGetAllOperation<Income> {
  final IncomeDAO _incomeDAO = IncomeDAO();

  @override
  Future<void> add(Income entity) async {
    //await _incomeDAO.createIncome(income: entity, personId: currentUser!.uid);
  }

  @override
  Future<void> delete(String id) async {
    await _incomeDAO.deleteIncome(incomeId: id);
  }

  @override
  Stream<List<Income>> getAll() {
    return _incomeDAO.readIncomes();
  }

  @override
  Future<void> update(Income entity) async {
    await _incomeDAO.updateIncome(income: entity);
  }
}
