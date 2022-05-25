import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projeto_controle_financeiro/cache/cache.dart';
import 'package:projeto_controle_financeiro/di/setup_locator.dart';

import '../exceptions/exceptions.dart';
import '../models/models.dart';

class AuthenticationRepository {
  AuthenticationRepository(
      {Cache? cache,
      firebase_auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn})
      : _cache = cache ?? getIt<Cache>(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final Cache _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  static const userCacheKey = '__user_cache_key__';

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.save(userCacheKey, user.toJson());
      return user;
    });
  }

  User get currentUser {
    final jsonData = _cache.read(userCacheKey);
    if (jsonData != null) {
      return User.fromJson(jsonData);
    } else {
      return User.empty;
    }
  }

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      await user!.updateDisplayName(name);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  Future<void> sendEmailVerification() async {
    final user = currentUser;
    if (user != User.empty && user.emailVerified == false) {
      await firebase_auth.FirebaseAuth.instance.currentUser!
          .sendEmailVerification();
    }
  }

  Future<bool> checkEmailVerified() async {
    await firebase_auth.FirebaseAuth.instance.currentUser!.reload();
    bool isEmailVerfied =
        firebase_auth.FirebaseAuth.instance.currentUser!.emailVerified;
    final user = currentUser;
    final newUser = user.copyWith(emailVerified: isEmailVerfied);
    _cache.save(userCacheKey, newUser.toJson());
    return isEmailVerfied;
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
        emailVerified: emailVerified);
  }
}
