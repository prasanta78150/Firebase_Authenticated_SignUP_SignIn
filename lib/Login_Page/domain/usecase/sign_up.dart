import 'package:firebase_bloc_loginpage/Login_Page/domain/Entity/auth_user.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/repositry/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<AuthUser> call({
    required String name,
    required String password,
    required String email,
  }) {
    return repository.signup(name: name, email: email, password: password);
  }
}
