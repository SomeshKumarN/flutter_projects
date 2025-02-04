import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _TabsScreebState();
  }
}

class _TabsScreebState extends State<TabsScreen> {
  var _currentIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleFavouriteMeal(Meal meal) {
    if (_favouriteMeals.contains(meal)) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showMessage("Removed from Favourites");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showMessage("Added to Favourites");
      });
    }
  }

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _setScreen(String identifier) {
    if (identifier == "meals") {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen =
        CategoriesScreen(onToggleFavourite: _toggleFavouriteMeal);
    var currentScreenTitle = "Categories";
    if (_currentIndex == 1) {
      currentScreen = MealsScreen(
          meals: _favouriteMeals, onToggleFavourite: _toggleFavouriteMeal);
      currentScreenTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentScreenTitle),
      ),
      body: currentScreen,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelectTab,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: "Your Favourites"),
        ],
      ),
    );
  }
}
