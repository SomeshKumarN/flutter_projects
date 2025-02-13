import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meals.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);
  String toggleMealFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      // state.remove(meal);
      state = state.where((m) => m.id != meal.id).toList();
      return "Removed from favorites!";
    } else {
      // state.add(meal);
      state = [...state, meal];
      return "Added to favorites!";
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) {
  return FavoriteMealNotifier();
});
