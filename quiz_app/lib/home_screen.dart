import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 51, 12, 123),
              const Color.fromARGB(255, 51, 12, 123)
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/images/quiz-logo.png",
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Learn Flutter the fun way!",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 238, 237, 237),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Start Quiz',
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 238, 237, 237),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
