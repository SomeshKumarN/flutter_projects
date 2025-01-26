import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals_screen.dart';

class NavigationHelper {
  static void navigateToMealsScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: "",
        meals: [],
      ),
    ));
  }
}
