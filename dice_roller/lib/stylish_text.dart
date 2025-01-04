import 'package:flutter/material.dart';

class StylishTest extends StatelessWidget {
  const StylishTest(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      style: const TextStyle(
        fontSize: 28,
        color: Colors.white,
      ),
      text,
    );
  }
}
