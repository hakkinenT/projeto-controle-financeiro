import '../../models/models.dart';

abstract class IUserRepository {
  Future<bool> addUser({required User user});
  Future<bool> updateUser({required User user});
  Future<bool> deleteUser({required String userId});
}
