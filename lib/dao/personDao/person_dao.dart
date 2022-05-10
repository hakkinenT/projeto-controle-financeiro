import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

class PersonDAO {
  final _personDAO = FirebaseFirestore.instance.collection('person');

  Future createPerson({required Person person}) async {
    await _personDAO.doc(person.userId).set(person.toJson());
  }

  Future<Person?> readPerson({required String personId}) async {
    final snapshot = await _personDAO.doc(personId).get();
    if (snapshot.exists) {
      return Person.fromJson(snapshot.data()!);
    } else {
      return null;
    }
  }

  Future updatePerson({required Person person}) async {
    await _personDAO.doc(person.id).update(person.toJson());
  }

  Future deletePerson({required String personId}) async {
    await _personDAO.doc(personId).delete();
  }
}
