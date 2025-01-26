import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';

class MealsWidget extends StatelessWidget {
  const MealsWidget({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(meal.title),
    );
  }
}
