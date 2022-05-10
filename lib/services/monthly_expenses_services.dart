import 'package:projeto_controle_financeiro/modules/userManagement/user_management.dart';

import '../dao/dao.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class MonthlyExpensesServices
    implements DataRepositoryWithGetAllOperation<MonthlyExpenses> {
  final MonthlyExpensesDAO _mExpensesDAO = MonthlyExpensesDAO();

  @override
  Future<void> add(MonthlyExpenses entity) async {
    UserManagement userManagement = UserManagement();
    var currentUser = userManagement.currentUser;
    await _mExpensesDAO.createMonthlyExpenses(
        mExpenses: entity, personId: currentUser!.uid);
  }

  @override
  Future<void> delete(String id) async {
    await _mExpensesDAO.deleteMonthlyExpenses(mExpensesId: id);
  }

  @override
  Stream<List<MonthlyExpenses>> getAll() {
    return _mExpensesDAO.readMonthlyExpenses();
  }

  @override
  Future<void> update(MonthlyExpenses entity) async {
    await _mExpensesDAO.updateMonthlyExpenses(mExpenses: entity);
  }
}
