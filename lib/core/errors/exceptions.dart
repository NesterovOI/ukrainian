import 'package:ukrainian/core/theme/app_strings.dart';

abstract class AuthException implements Exception {
  final String message;

  const AuthException(this.message);
}

class WeakPasswordAuthException extends AuthException {
  const WeakPasswordAuthException() : super(AppStrings.weakPassword);
}

class EmailAlreadyInUseAuthException extends AuthException {
  const EmailAlreadyInUseAuthException() : super(AppStrings.emailAlreadyInUse);
}

class InvalidEmailOrPasswordAuthException extends AuthException {
  const InvalidEmailOrPasswordAuthException()
    : super(AppStrings.invalidEmailOrPassword);
}

class GenericAuthException extends AuthException {
  const GenericAuthException([String? message])
    : super(message ?? AppStrings.invalidAuth);
}

class UserNotFoundAuthException extends AuthException {
  const UserNotFoundAuthException(): super(AppStrings.userNotFound);
}
