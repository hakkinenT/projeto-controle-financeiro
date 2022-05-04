import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../exceptions/exceptions.dart';
import '../../../../models/models.dart';
import '../../../../repositories/repositories.dart';

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return UserModel(
          uid: user?.uid,
          displayName: user?.displayName,
          email: user?.email,
          emailVerified: user?.emailVerified);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      }
    }
    return null;
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      return UserModel(
          uid: user?.uid,
          displayName: user?.displayName,
          email: user?.email,
          emailVerified: user?.emailVerified);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future? signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) => UserModel(
        uid: user?.uid,
        email: user?.email,
        emailVerified: user?.emailVerified));
  }

  @override
  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
