import 'package:flutter/material.dart';
import 'package:quiz_app/home_screen.dart';

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 51, 12, 123),
                const Color.fromARGB(255, 51, 12, 123)
              ],
            ),
          ),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
