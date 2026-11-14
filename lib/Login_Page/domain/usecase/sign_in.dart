
import 'package:firebase_bloc_loginpage/Login_Page/domain/repositry/auth_repository.dart';

import '../Entity/auth_user.dart';

class SignIn {

  final AuthRepository repository;

  SignIn(this.repository);

  Future<AuthUser> call({
    required String password,
    required String email
}){
    return repository.signin(email: email, password: password);
  }
}