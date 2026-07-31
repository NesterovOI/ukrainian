import 'package:ukrainian/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Stream<UserEntity?> get authStateChanges;

  Future<void> sendPasswordResetEmail({required String email});
}
