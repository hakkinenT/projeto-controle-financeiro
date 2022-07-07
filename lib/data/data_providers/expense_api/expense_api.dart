import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_controle_financeiro/utils/enum_map.dart';
import 'package:projeto_controle_financeiro/utils/string_to_enum.dart';

import '../../models/models.dart';

class ExpenseAPI {
  final _db = FirebaseFirestore.instance;
  final _expenseCollection = 'expenses';

  Future createExpense(
      {required Expense expense, required String userId}) async {
    var expenseToJson = {
      "description": expense.description,
      "value": expense.value,
      "classification": classificationEnumMap[expense.classification],
      "type": typeEnumMap[expense.type],
      "expirationDate": expense.expirationDate,
      "refUser": _db.doc('user/$userId')
    };
    await _db.collection(_expenseCollection).doc().set(expenseToJson);
  }

  Future<List<Expense>> readExpense() async {
    dynamic data;
    var expenseList = <Expense>[];
    QuerySnapshot expenses = await _db.collection(_expenseCollection).get();
    for (var i = 0; i < expenses.size; i++) {
      data = expenses.docs[i].data();
      var expense = Expense(
          id: expenses.docs[i].id,
          description: data['description'],
          value: double.parse(data['value'].toString()) / 100,
          classification: stringToClassification[data['classification']]!,
          type: stringToType[data['type']]!,
          expirationDate: data['expirationDate']?.toDate(),
          user: User(id: data['refUser'].id));

      expenseList.add(expense);
    }
    return expenseList;
  }

  Future updateExpense({required Expense expense}) async {
    var expenseToJson = {
      "description": expense.description,
      "value": expense.value,
      "category": classificationEnumMap[expense.classification],
      "type": typeEnumMap[expense.type],
      "expirationDate": expense.expirationDate,
    };
    await _db
        .collection(_expenseCollection)
        .doc(expense.id)
        .update(expenseToJson);
  }

  Future deleteExpense({required String expenseId}) async {
    await _db.collection(_expenseCollection).doc(expenseId).delete();
  }
}
