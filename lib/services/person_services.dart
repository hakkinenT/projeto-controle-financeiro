import '../dao/dao.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class PersonServices implements DataRepositoryWithGetOperation<Person> {
  final PersonDAO _personDAO = PersonDAO();

  @override
  Future<void> add(Person entity) async {
    await _personDAO.createPerson(person: entity);
  }

  @override
  Future<void> delete(String id) async {
    await _personDAO.deletePerson(personId: id);
  }

  @override
  Future<Person> get(String id) async {
    final person = await _personDAO.readPerson(personId: id);
    return person!;
  }

  @override
  Future<void> update(Person entity) async {
    await _personDAO.updatePerson(person: entity);
  }
}
