import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_bloc.dart';
import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_event.dart';
import 'package:firebase_bloc_loginpage/Login_Page/Presentation/screens/HomeScrren.dart';
import 'package:firebase_bloc_loginpage/Login_Page/data/datasources/auth_remote_datasource.dart';
import 'package:firebase_bloc_loginpage/Login_Page/data/repositry/auth_repository_impl.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/usecase/get_current_user.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/usecase/sign_in.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/usecase/sign_out.dart';
import 'package:firebase_bloc_loginpage/Login_Page/domain/usecase/sign_up.dart';
import 'package:firebase_bloc_loginpage/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Login_Page/Presentation/Bloc/auth_state.dart';
import 'Login_Page/Presentation/screens/SignUpScreen.dart';
import 'Login_Page/Presentation/screens/login_scrren.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final remoteDataSource = AuthRemoteDataSource(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  );

  final repository = AuthRepositoryImpl(remoteDataSource);

  runApp(
    BlocProvider(
      create: (_) => AuthBloc(
        signUp: SignUp(repository),
        signIn: SignIn(repository),
        signOut: SignOut(repository),
        getCurrentUser: GetCurrentUser(repository),
      )..add(AuthCheckRequested()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc , AuthState>(
            builder:(context , state){
              if(state is AuthLoading || state is AuthInitial){
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if(state is AuthAuthenticated){
                return const Homescrren();
              }

              return Signupscreen();

            }

        ));
  }
}
