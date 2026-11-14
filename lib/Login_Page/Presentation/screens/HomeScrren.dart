import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBar.dart';
import '../Widgets/ElevatedButton.dart';
import 'login_scrren.dart';

class Homescrren extends StatefulWidget {
  const Homescrren({super.key});

  @override
  State<Homescrren> createState() => _HomescrrenState();
}

class _HomescrrenState extends State<Homescrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title:"Home Screen" , isLogout: true,),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is Home Screen page"),

            // CustomeElevatedButton(
            //   onPressed: (){
            //     Navigator.pop(context,
            //         MaterialPageRoute(builder: (context) => const LoginScrren())
            //     );
            //   },
            //   buttonName: Text('Log Out'),
            // )
          ],
        ),
      ) ,
    );
  }
}
