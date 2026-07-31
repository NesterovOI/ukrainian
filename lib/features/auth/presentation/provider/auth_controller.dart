import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/auth/presentation/provider/auth_providers.dart';
import 'package:ukrainian/features/auth/presentation/provider/user_name_provider.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final signUpUseCase = ref.read(signUpUseCaseProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => signUpUseCase(name, email, password));
    if (!state.hasError) {
      await ref.read(userNameProvider.notifier).setUserName(name);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    final signInUseCase = ref.read(signInUseCaseProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => signInUseCase(email, password));
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}

final authControllerProvider =
AsyncNotifierProvider<AuthController, void>(AuthController.new);
