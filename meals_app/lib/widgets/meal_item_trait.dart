import 'package:dart_casing/dart_casing.dart';
import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        SizedBox(width: 6),
        Text(
          Casing.pascalCase(label),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
