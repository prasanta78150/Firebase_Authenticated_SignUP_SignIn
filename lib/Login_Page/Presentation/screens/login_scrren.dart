import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_bloc.dart';
import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/auth_state.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/ElevatedButton.dart';
import 'HomeScrren.dart';

class LoginScrren extends StatefulWidget {
  const LoginScrren({super.key});

  @override
  State<LoginScrren> createState() => _LoginScrrenState();
}

class _LoginScrrenState extends State<LoginScrren> {
  TextEditingController _passwordControler = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Log In"),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          bool isLoading = state is AuthLoading;
          return Form(
            key: _formKey,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter the Email";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 12,),
                  TextFormField(
                    controller: _passwordControler,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "Please Enter the Password";
                      }
                    },
                  ),

                  SizedBox(height: 15,),
                  CustomeElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                SignInRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordControler.text.trim(),
                                ),
                              );
                            }
                          },
                    buttonName: Text("Log In"),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );

            if (state is AuthAuthenticated) {
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordControler.clear();
    _passwordControler.clear();
  }
}
