import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorite_provider.dart';

const Map<Filter, bool> kinitialFilters = {
  Filter.glutonfree: false,
  Filter.latosfree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabsScreebState();
  }
}

class _TabsScreebState extends ConsumerState<TabsScreen> {
  var _currentIndex = 0;

  Map<Filter, bool> _selectedFilters = kinitialFilters;

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(selectedFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kinitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutonfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.latosfree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget currentScreen = CategoriesScreen(availableMeals: availableMeals);
    var currentScreenTitle = "Categories";
    if (_currentIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      currentScreen = MealsScreen(meals: favoriteMeals);
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
