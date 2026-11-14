
import 'package:firebase_bloc_loginpage/Login_Page/domain/repositry/auth_repository.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call(){
    return repository.signOut();
  }
}