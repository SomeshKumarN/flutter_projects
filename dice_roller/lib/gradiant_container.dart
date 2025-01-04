import 'package:basic/dice_roller.dart';
import 'package:flutter/material.dart';

class GradiantWidget extends StatelessWidget {
  const GradiantWidget({required this.text, required this.colors, super.key});
  final String text;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: Center(child: DiceRoller()),
    );
  }
}
