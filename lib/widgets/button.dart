// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? onPressed;

  const ButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 10,
          primary: buttonColor),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
