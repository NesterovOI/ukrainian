import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:ukrainian/features/auth/domain/entities/user_entity.dart';

class AuthModel extends UserEntity{

  const AuthModel({
    required super.uid,
    super.name,
    required super.email,
  });

  factory AuthModel.fromFirebaseUser(firebase_auth.User user) {
    return AuthModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email ?? '',
    );
  }
}