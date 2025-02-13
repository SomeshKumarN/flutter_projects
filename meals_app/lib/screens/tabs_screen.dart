import 'package:flutter/material.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorite_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';

const Map<Filter, bool> kinitialFilters = {
  Filter.glutonfree: false,
  Filter.lactosfree: false,
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

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutonfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactosfree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
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
