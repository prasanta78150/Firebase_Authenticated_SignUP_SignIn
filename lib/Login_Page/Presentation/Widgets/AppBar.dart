import 'package:firebase_bloc_loginpage/Login_Page/Presentation/Bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/auth_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isLogout ;

   CustomAppBar({super.key, required this.title,  this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black54,
      title: Title(
        color: Colors.white,
        child: Text(
          "$title",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      actions: isLogout ? [
        IconButton(onPressed: (){
          context.read<AuthBloc>().add(
            LogOutRequested()
          );
        }, icon: Icon(Icons.logout , color: Colors.white,))
      ] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
