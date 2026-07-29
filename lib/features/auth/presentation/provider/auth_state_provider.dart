import 'package:riverpod/riverpod.dart';
import 'package:ukrainian/features/auth/domain/entities/user_entity.dart';
import 'package:ukrainian/features/auth/presentation/provider/auth_providers.dart';

final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});
