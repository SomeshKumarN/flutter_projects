import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startScreen, {super.key});

  final void Function() startScreen;
  @override
  Widget build(Object context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          "assets/images/quiz-logo.png",
          width: 300,
          color: const Color.fromARGB(150, 255, 255, 255),
        ),
        const SizedBox(height: 50),
        const Text(
          "Learn Flutter the fun way!",
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 238, 237, 237),
          ),
        ),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          icon: const Icon(Icons.arrow_right_alt),
          onPressed: startScreen,
          style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
          label: const Text('Start Quiz!!'),
        ),
      ]),
    );
  }
}
