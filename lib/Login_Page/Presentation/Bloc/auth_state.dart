
import 'package:equatable/equatable.dart';

import '../../domain/Entity/auth_user.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState{}

class AuthLoading extends AuthState{}

class AuthAuthenticated extends AuthState{
  final AuthUser user;

  AuthAuthenticated(this.user);

  List<Object?> get props => [user.uid , user.email , user];

}

class AuthUnauthenticated extends AuthState{}

class AuthFailure extends AuthState{
  final String message;

  AuthFailure(this.message);

  List<Object?> get props => [message];
}

