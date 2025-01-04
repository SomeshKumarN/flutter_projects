import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(Object context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          "assets/images/quiz-logo.png",
          width: 300,
        ),
        const SizedBox(height: 50),
        const Text(
          "Learn Flutter the fun way!",
          style: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 238, 237, 237),
          ),
        ),
        const SizedBox(height: 30),
        OutlinedButton(
          onPressed: () {},
          child: const Text(
            'Start Quiz!!',
            style: TextStyle(
              fontSize: 20,
              color: const Color.fromARGB(255, 238, 237, 237),
            ),
          ),
        )
      ]),
    );
  }
}
