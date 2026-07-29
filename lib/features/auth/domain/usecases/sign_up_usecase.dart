import 'package:ukrainian/features/auth/domain/entities/user_entity.dart';
import 'package:ukrainian/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<UserEntity> call(String name, String email, String password) async {
    return await authRepository.signUpWithEmail(
        name: name, email: email, password: password);
  }
}