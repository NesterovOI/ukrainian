import 'package:riverpod/riverpod.dart';
import 'package:ukrainian/features/auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'package:ukrainian/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ukrainian/features/auth/domain/repositories/auth_repository.dart';
import 'package:ukrainian/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:ukrainian/features/auth/domain/usecases/sign_up_usecase.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return FirebaseAuthRemoteDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
      remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(authRepository: ref.watch(authRepositoryProvider));
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(authRepository: ref.watch(authRepositoryProvider));
});