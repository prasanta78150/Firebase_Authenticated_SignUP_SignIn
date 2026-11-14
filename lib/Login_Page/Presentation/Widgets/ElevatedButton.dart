import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomeElevatedButton extends StatelessWidget{
  final Widget? buttonName;
  final VoidCallback? onPressed;

  CustomeElevatedButton({
    super.key,
    required this.buttonName,
    required this.onPressed
});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child:buttonName
      ),
    );
  }
}