import 'package:firebase_bloc_loginpage/Login_Page/domain/Entity/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> signup({
    required String name,
    required String email,
    required String password
});

  Future<AuthUser> signin({
    required String email,
    required String password
});

  Future<void> signOut();

  AuthUser? getCurrentUser();

  
}