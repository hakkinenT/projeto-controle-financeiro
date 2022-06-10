import '../data_providers/data_providers.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class UserRepository implements IUserRepository {
  final _api = UserAPI();

  @override
  Future<bool> addUser({required User user}) async {
    try {
      await _api.createUser(user: user);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteUser({required String userId}) async {
    try {
      await _api.deleteUser(userId: userId);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateUser({required User user}) async {
    try {
      _api.updateUser(user: user);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
