import 'package:ukrainian/features/auth/domain/repositories/auth_repository.dart';
import 'package:ukrainian/features/auth/domain/entities/user_entity.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<UserEntity> call(String email, String password) async {
    return authRepository.signInWithEmail(email: email, password: password);
  }
}