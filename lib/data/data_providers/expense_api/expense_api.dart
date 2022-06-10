import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_controle_financeiro/utils/enum_map.dart';

import '../../models/models.dart';

class ExpenseAPI {
  final _db = FirebaseFirestore.instance;
  final _expenseCollection = 'expenses';

  Future createExpense(
      {required Expense expense, required String userId}) async {
    var expenseToJson = {
      "description": expense.description,
      "value": expense.value,
      "category": classificationEnumMap[expense.classification],
      "type": typeEnumMap[expense.type],
      "expiration_date": expense.expirationDate,
      "refUser": _db.doc('user/$userId')
    };
    await _db.collection(_expenseCollection).doc().set(expenseToJson);
  }

  Stream<List<Expense>> readExpense() {
    return _db.collection(_expenseCollection).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Expense.fromJson(doc.data())).toList());
  }

  Future updateExpense({required Expense expense}) async {
    await _db
        .collection(_expenseCollection)
        .doc(expense.id)
        .update(expense.toJson());
  }

  Future deleteExpense({required String expenseId}) async {
    await _db.collection(_expenseCollection).doc(expenseId).delete();
  }
}
