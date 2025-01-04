import 'package:basic/gradiant_container.dart';
import 'package:flutter/material.dart';

void main() {
  List<Color> color = [
    const Color.fromARGB(255, 3, 47, 83),
    Color.fromARGB(255, 3, 47, 83)
  ];
  String text = 'Sabari Yathra1';
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradiantWidget(text: text, colors: color),
      ),
    ),
  );
}
