import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ukrainian/core/errors/exceptions.dart';
import 'package:ukrainian/features/auth/data/models/auth_model.dart';
import 'package:ukrainian/core/theme/theme.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Stream<AuthModel?> get authStateChanges;
}

class FirebaseAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthRemoteDataSourceImpl({firebase_auth.FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  Future<AuthModel> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception(AppStrings.invalidCreateUser);
      }

      await user.updateDisplayName(name.trim());
      await user.reload();

      final updatedUser = _firebaseAuth.currentUser ?? user;

      return AuthModel.fromFirebaseUser(updatedUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<AuthModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception(AppStrings.userNotFound);
      }

      return AuthModel.fromFirebaseUser(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<AuthModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return AuthModel.fromFirebaseUser(firebaseUser);
    });
  }

  Exception _handleFirebaseAuthException(
    firebase_auth.FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'weak-password':
        return const WeakPasswordAuthException();
      case 'email-already-in-use':
        return const EmailAlreadyInUseAuthException();
      case 'invalid-email':
        return const InvalidEmailOrPasswordAuthException();
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const InvalidEmailOrPasswordAuthException();
      default:
        return GenericAuthException(e.message);
    }
  }
}
