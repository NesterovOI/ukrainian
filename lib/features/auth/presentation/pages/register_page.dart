import 'package:flutter/material.dart';
import 'package:ukrainian/core/navigation/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukrainian/features/auth/presentation/provider/auth_controller.dart';
import 'package:ukrainian/features/auth/presentation/widget/custom_text_from_field.dart';
import 'package:ukrainian/core/theme/theme.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordTwoController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.spaceM),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFromField(
                  controller: _nameController,
                  labelText: AppStrings.nameLabelText,
                  hintText: AppStrings.nameHintText,
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: IconButton(
                    onPressed: () => _nameController.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceS),
                CustomTextFromField(
                  controller: _emailController,
                  labelText: AppStrings.emailLabelText,
                  hintText: AppStrings.emailHintText,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: IconButton(
                    onPressed: () => _emailController.clear(),
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
                const SizedBox(height: AppDimensions.spaceS),
                CustomTextFromField(
                  controller: _passwordTwoController,
                  labelText: AppStrings.passwordLabelText2,
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
                const SizedBox(height: AppDimensions.spaceL),
                const Text(AppStrings.alreadyHaveAccount),
                const SizedBox(height: AppDimensions.spaceS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go(AppRouters.loginPage);
                      },
                      child: const Text(AppStrings.signIn),
                    ),
                    const SizedBox(width: AppDimensions.spaceXS),
                    ElevatedButton(
                        onPressed: () {
                          if (!_isValidInput()) return;
                          ref
                              .read(authControllerProvider.notifier)
                              .signUp(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        },
                        child: const Text(AppStrings.register),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  bool _isValidInput() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final String passwordOne = _passwordController.text;
    final String passwordTwo = _passwordTwoController.text;

    if (name.isEmpty) {
      _showErrorSnackBar(AppStrings.enterName);
      return false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      _showErrorSnackBar(AppStrings.enterEmail);
      return false;
    }

    if (passwordOne.length < 6) {
      _showErrorSnackBar(AppStrings.passwordShort);
      return false;
    }

    if (passwordOne != passwordTwo) {
      _showErrorSnackBar(AppStrings.passwordMatch);
      return false;
    }

    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        content: Text(message),
      ),
    );
  }
}
