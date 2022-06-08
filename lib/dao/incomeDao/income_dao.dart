import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_controle_financeiro/utils/enum_map.dart';

import '../../models/models.dart';

class IncomeDAO {
  final _incomeDAO = FirebaseFirestore.instance.collection('income');
  final _db = FirebaseFirestore.instance;

  Future createIncome(
      {required Income income, required String personId}) async {
    var incomeToJson = {
      "description": income.description,
      "total": income.value,
      "type": typeEnumMap[income.type],
      "refPerson": _db.doc('person/$personId')
    };
    await _incomeDAO.doc().set(incomeToJson);
  }

  Stream<List<Income>> readIncomes() {
    return _incomeDAO.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Income.fromJson(doc.data())).toList());
  }

  Future updateIncome({required Income income}) async {
    await _incomeDAO.doc(income.id).update(income.toJson());
  }

  Future deleteIncome({required String incomeId}) async {
    await _incomeDAO.doc(incomeId).delete();
  }
}
