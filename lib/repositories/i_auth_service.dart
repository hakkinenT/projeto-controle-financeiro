import '../models/models.dart';

abstract class IAuthService {
  Future<UserModel?> signInWithEmailAndPassword(String email, String password);
  Future<UserModel?> signInWithGoogle();
  Stream<UserModel?> get user;
  Future? signOut();
  Future<void> signOutFromGoogle();
}
