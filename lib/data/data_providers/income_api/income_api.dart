import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/utils.dart';
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

  Future<List<Income>> readIncomes() async {
    /*return _db.collection(_incomeCollection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Income.fromJson(doc.data())).toList());*/
    dynamic data;
    var incomeList = <Income>[];
    QuerySnapshot incomes = await _db.collection(_incomeCollection).get();
    for (var i = 0; i < incomes.size; i++) {
      data = incomes.docs[i].data();
      var income = Income(
          id: incomes.docs[i].id,
          description: data['description'],
          type: stringToType[data['type']]!,
          value: double.parse(data['value'].toString()),
          user: User(id: data['refUser'].id));
      incomeList.add(income);
    }
    return incomeList;
  }

  Future updateIncome({required Income income}) async {
    var incomeToJson = {
      "description": income.description,
      "value": income.value,
      "type": typeEnumMap[income.type],
    };
    await _db.collection(_incomeCollection).doc(income.id).update(incomeToJson);
  }

  Future deleteIncome({required String incomeId}) async {
    await _db.collection(_incomeCollection).doc(incomeId).delete();
  }
}
