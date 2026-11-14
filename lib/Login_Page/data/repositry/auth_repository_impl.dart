
import 'package:firebase_bloc_loginpage/Login_Page/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_bloc_loginpage/Login_Page/data/model/user_model.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/repositry/auth_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/Entity/auth_user.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthUser> signup({
    required String name ,
    required String email ,
    required String password ,
}){
return remoteDataSource.signUP(name: name, email: email, password: password);
  }

  @override
  Future<AuthUser> signin({
    required String email ,
    required String password ,
}){
    return remoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<void> signOut(){
    return remoteDataSource.signOut();
  }

  @override
  AuthUser? getCurrentUser(){
    return remoteDataSource.getCurrentUser();
  }

}