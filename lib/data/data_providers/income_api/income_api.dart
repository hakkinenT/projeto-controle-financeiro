import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_controle_financeiro/utils/enum_map.dart';

import '../../models/models.dart';

class IncomeAPI {
  final _incomeCollection = 'incomes';
  final _db = FirebaseFirestore.instance;

  Future createIncome({required Income income, required String userId}) async {
    var incomeToJson = {
      "description": income.description,
      "value": income.value,
      "type": typeEnumMap[income.type],
      "refUser": _db.doc('user/$userId')
    };
    await _db.collection(_incomeCollection).doc().set(incomeToJson);
  }

  Stream<List<Income>> readIncomes() {
    return _db.collection(_incomeCollection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Income.fromJson(doc.data())).toList());
  }

  Future updateIncome({required Income income}) async {
    await _db
        .collection(_incomeCollection)
        .doc(income.id)
        .update(income.toJson());
  }

  Future deleteIncome({required String incomeId}) async {
    await _db.collection(_incomeCollection).doc(incomeId).delete();
  }
}
