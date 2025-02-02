import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreebState();
  }
}

class _TabsScreebState extends State<TabsScreen> {
  var _currentIndex = 0;

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = CategoriesScreen();
    var currentScreenTitle = "Categories";
    if (_currentIndex == 1) {
      currentScreen = MealsScreen(meals: []);
      currentScreenTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentScreenTitle),
      ),
      body: currentScreen,
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
