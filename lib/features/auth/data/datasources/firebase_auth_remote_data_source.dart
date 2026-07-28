import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ukrainian/features/auth/data/models/auth_model.dart';

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

  Stream<AuthModel?> get authStateChange;
}

class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  // TODO: implement authStateChange
  Stream<AuthModel?> get authStateChange => throw UnimplementedError();

  @override
  Future<AuthModel> signInWithEmail({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }
}
