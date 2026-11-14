import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_event.dart';
import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_state.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/usecase/get_current_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/sign_in.dart';
import '../../domain/usecase/sign_out.dart';
import '../../domain/usecase/sign_up.dart';

class AuthBloc  extends Bloc<AuthEvent , AuthState>{
  final SignUp signUp;
  final SignIn signIn;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

   AuthBloc({
    required this.signUp ,
    required this.signIn ,
    required this.signOut ,
    required this.getCurrentUser
}) : super(AuthInitial()) {

    on<AuthCheckRequested>((event, emit){
      final user = getCurrentUser();
      if(user != null){
        emit(AuthAuthenticated(user));
      }else{
        emit(AuthUnauthenticated());
      }
    });

    // SignUp
     on<SignUpRequested>((event , emit) async{
       emit(AuthLoading());

       try{
          final user = await signUp(
            name: event.name,
            email: event.email,
            password: event.Password,
          );

          emit(AuthAuthenticated(user));
       }on FirebaseAuthException catch(e){
          emit(AuthFailure(e as String));
       }
       catch(e){
         emit(AuthFailure('Something went wrong. Please try again.'));
       }
    });

     // SignIn
     on<SignInRequested>((event , emit) async{
       emit(AuthLoading());

       try{
         final user = await signIn(
           email: event.email,
           password: event.password
         );
         emit(AuthAuthenticated(user));
       }on FirebaseAuthException catch(e){
         emit(e as AuthFailure);
       }catch(e){
         emit(AuthFailure('Something went wrong. Please try again.'));
       }
     });

     // Log out
     on<LogOutRequested>((event , emit) async{
       emit(AuthLoading());

       try{
         await signOut();
         emit(AuthUnauthenticated());
       }catch(e){
         emit(AuthFailure('Unable to logout. Please try again.'));
       }
     });

  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'weak-password':
        return 'Password must be stronger.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      default:
        return e.message ?? 'Authentication failed.';
    }
  }

}