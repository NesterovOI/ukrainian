import 'package:ukrainian/features/auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'package:ukrainian/features/auth/domain/entities/user_entity.dart';
import 'package:ukrainian/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.signUpWithEmail(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.signInWithEmail(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async{
    return remoteDataSource.signOut();
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return remoteDataSource.authStateChange;
  }
}
