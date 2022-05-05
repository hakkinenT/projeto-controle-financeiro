import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_controle_financeiro/exceptions/exceptions.dart';
import 'package:projeto_controle_financeiro/models/user_model.dart';
import 'package:projeto_controle_financeiro/repositories/i_user_management.dart';

class UserManagement implements IUserManagement {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  @override
  void deleteUser() async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {}
    }
  }

  @override
  Future<UserModel?> registrationWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return UserModel(
          uid: user?.uid,
          displayName: user?.displayName,
          email: user?.email,
          emailVerified: user?.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  void reauthenticateUser(
      {required String email, required String password}) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await _auth.currentUser!.reauthenticateWithCredential(credential);
  }

  void updateUserName({
    required String newName,
  }) async {
    try {
      await _auth.currentUser!.updateDisplayName(newName);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void updateEmail({required String newEmail}) async {
    try {
      await _auth.currentUser!.updateEmail(newEmail);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void updatePassword({required String newPassword}) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
