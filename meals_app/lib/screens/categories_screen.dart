import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _onSelectCategory(BuildContext context, Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            title: category.title, meals: _getMealsByCategory(category)),
      ),
    );
  }

  List<Meal> _getMealsByCategory(Category category) {
    return dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Category'),
      ),
      body: GridView(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoriesWidget(
              category: category,
              onSelectCategory: () {
                _onSelectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
