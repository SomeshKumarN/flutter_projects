import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutonfree, latosfree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutonfree: false,
          Filter.latosfree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });
  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});
