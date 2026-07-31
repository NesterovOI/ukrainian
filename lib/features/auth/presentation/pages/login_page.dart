import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ukrainian/core/errors/exceptions.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:ukrainian/features/auth/presentation/provider/auth_controller.dart';
import 'package:ukrainian/features/auth/presentation/widget/custom_text_from_field.dart';
import 'package:ukrainian/core/theme/theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authControllerProvider, (previous, next) {
      if (next case AsyncError(:final error) when !next.isLoading) {
        final String errorMessage = error is AuthException
            ? error.message
            : error.toString().replaceAll('Exception: ', '');

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: AppColors.error,
            ),
          );
        });
      }

      if (previous?.isLoading == true && !next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.sentLetterOnEmail),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFromField(
                controller: _emailController,
                labelText: AppStrings.emailLabelText,
                hintText: AppStrings.emailHintText,
                prefixIcon: const Icon(Icons.email),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _emailController.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              CustomTextFromField(
                controller: _passwordController,
                labelText: AppStrings.passwordLabelText,
                hintText: AppStrings.passwordHintText,
                isPassword: _isPasswordHidden,
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXS),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _showForgotPasswordDialog(context, ref);
                  },
                  child: const Text(AppStrings.forgotPassword),
                ),
              ),
              const SizedBox(height: AppDimensions.spaceS),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.go(AppRouters.registerPage);
                    },
                    child: Text(AppStrings.register),
                  ),
                  const SizedBox(width: AppDimensions.spaceXS),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            ref
                                .read(authControllerProvider.notifier)
                                .signIn(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                );
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(AppStrings.signIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showForgotPasswordDialog(BuildContext context, WidgetRef ref) {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text(AppStrings.restorationPassword),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppStrings.enterYourEmail),
              const SizedBox(height: AppDimensions.spaceM),
              CustomTextFromField(
                controller: emailController,
                labelText: AppStrings.emailLabelText,
                hintText: AppStrings.enterYourEmailCorrect,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_outlined),
                suffixIcon: IconButton(
                  onPressed: () {
                    emailController.clear();
                  },
                  icon: Icon(Icons.clear),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.enterYourEmailCorrect;
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final email = emailController.text.trim();
                Navigator.pop(dialogContext);

                await ref
                    .read(authControllerProvider.notifier)
                    .sendPasswordResetEmail(email: email);
              }
            },
            child: const Text(AppStrings.send),
          ),
        ],
      );
    },
  );
}
