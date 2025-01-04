import 'package:flutter/material.dart';
import 'package:quiz_app/home_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
