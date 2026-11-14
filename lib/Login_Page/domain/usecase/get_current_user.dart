
import 'package:firebase_bloc_loginpage/Login_Page/domain/Entity/auth_user.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/repositry/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  AuthUser? call(){
    return repository.getCurrentUser();
  }
}