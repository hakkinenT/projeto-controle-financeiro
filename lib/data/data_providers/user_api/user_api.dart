import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

class UserAPI {
  final _db = FirebaseFirestore.instance;
  final _userCollection = 'users';

  Future createUser({required User user}) async {
    var userToJson = {
      "name": user.name,
      "email": user.email,
      "photo": user.photo
    };

    await _db.collection(_userCollection).doc(user.id).set(userToJson);
  }

  Future updateUser({required User user}) async {
    await _db.collection(_userCollection).doc(user.id).update(user.toJson());
  }

  Future deleteUser({required String userId}) async {
    await _db.collection(_userCollection).doc(userId).delete();
  }
}
