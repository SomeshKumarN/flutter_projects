import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  const OptionsButton(
      {required this.buttonText, required this.onTap, super.key});
  final String buttonText;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey,
        ),
        child: Text(buttonText));
  }
}
