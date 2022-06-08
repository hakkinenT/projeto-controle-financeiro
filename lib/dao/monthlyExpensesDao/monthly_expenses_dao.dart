import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_controle_financeiro/utils/enum_map.dart';

import '../../models/models.dart';

/*class MonthlyExpensesDAO {
  final _db = FirebaseFirestore.instance;
  final _mExpensesDao =
      FirebaseFirestore.instance.collection('monthly_expenses');

  Future createMonthlyExpenses(
      {required MonthlyExpenses mExpenses, required String personId}) async {
    var mExpensesToJson = {
      "description": mExpenses.total,
      "total": mExpenses.total,
      "category": categoryEnumMap[mExpenses.category],
      "refPerson": _db.doc('person/$personId')
    };
    await _mExpensesDao.doc().set(mExpensesToJson);
  }

  Stream<List<MonthlyExpenses>> readMonthlyExpenses() {
    return _mExpensesDao.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => MonthlyExpenses.fromJson(doc.data()))
        .toList());
  }

  Future updateMonthlyExpenses({required MonthlyExpenses mExpenses}) async {
    await _mExpensesDao.doc(mExpenses.id).update(mExpenses.toJson());
  }

  Future deleteMonthlyExpenses({required String mExpensesId}) async {
    await _mExpensesDao.doc(mExpensesId).delete();
  }
}
*/