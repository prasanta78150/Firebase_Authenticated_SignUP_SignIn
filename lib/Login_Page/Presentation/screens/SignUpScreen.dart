import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/auth_bloc.dart';
import '../Bloc/auth_state.dart';
import '../Widgets/AppBar.dart';
import '../Widgets/ElevatedButton.dart';
import 'HomeScrren.dart';
import 'login_scrren.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Sign Up"),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          final isLoading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: _inputDecoration("User Name"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter User Name";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 14,),
                  TextFormField(
                    controller: _emailControler,
                    decoration: _inputDecoration("Enter Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                          .hasMatch(value.trim())) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 14,),
                  TextFormField(
                    controller: _passwordControler,
                    decoration: _inputDecoration("Enter Password").copyWith(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                        icon: Icon(
                          _obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _obsecureText,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Password";
                      }

                      if (value.length < 6) {
                        return "password most less then 6 Letters";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  CustomeElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formkey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                SignUpRequested(
                                  name: _usernameController.text.trim(),
                                  email: _emailControler.text.trim(),
                                  Password: _passwordControler.text.trim(),
                                ),
                              );
                            }
                          },
                    buttonName: isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                      children: [
                        const TextSpan(text: "If Already exist then "),
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => const LoginScrren(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailControler.clear();
    _passwordControler.clear();
    _usernameController.clear();
  }
}
