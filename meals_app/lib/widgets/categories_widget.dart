import 'package:meals_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/navigator_screens.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });
  final Category category;
  final void Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge,
          selectionColor: Theme.of(context).colorScheme.onPrimaryFixed,
        ),
      ),
    );
  }
}
