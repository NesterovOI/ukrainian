import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/auth/presentation/provider/auth_controller.dart';
import 'package:ukrainian/features/auth/presentation/widget/custom_text_from_field.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/core/widgets/neobrutal_3d_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        child: Column(
          children: [
            CustomTextFromField(
              controller: _emailController,
              hintText: AppStrings.emailHintText,
            ),
            const SizedBox(height: AppDimensions.spaceS),
            CustomTextFromField(
              controller: _passwordController,
              hintText: AppStrings.passwordHintText,
              isPassword: true,
            ),
            const SizedBox(height: AppDimensions.spaceL),
            Neobrutal3DButton(
              onTap: isLoading
                  ? null
                  : () {
                      ref
                          .read(authControllerProvider.notifier)
                          .signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(AppStrings.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
