import 'package:firebase_bloc_loginpage/Login_Page/domain/Entity/auth_user.dart';

class UserModel extends AuthUser{
  const UserModel({
    required super.uid,
    required super.name ,
    required super.email
});

  Map<String,String> toJson(){
    return {
      'uid' : uid,
      'name' : name ,
      'email' : email ,
      'createdAt' :DateTime.now().toUtc().toIso8601String(),
    };
  }
}