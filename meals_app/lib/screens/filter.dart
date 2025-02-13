import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  FilterScreen({
    super.key,
  });

  @override
  ConsumerState<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  bool _glutonFreeFilterSet = false;
  bool _lactosFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilter = ref.read(filtersProvider);
    _glutonFreeFilterSet = activeFilter[Filter.glutonfree]!;
    _lactosFreeFilterSet = activeFilter[Filter.latosfree]!;
    _vegetarianFilterSet = activeFilter[Filter.vegetarian]!;
    _veganFilterSet = activeFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
      ),
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) {
            return ref.read(filtersProvider.notifier).setFilters({
              Filter.glutonfree: _glutonFreeFilterSet,
              Filter.latosfree: _lactosFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet
            });
          }
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutonFreeFilterSet,
              onChanged: (isChanged) {
                setState(() {
                  _glutonFreeFilterSet = isChanged;
                });
              },
              title: Text(
                "Gluton free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "only include gluten free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactosFreeFilterSet,
              onChanged: (isChanged) {
                setState(() {
                  _lactosFreeFilterSet = isChanged;
                });
              },
              title: Text(
                "Lactos free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "only include lactos free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChanged) {
                setState(() {
                  _vegetarianFilterSet = isChanged;
                });
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "only include vegetarian meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChanged) {
                setState(() {
                  _veganFilterSet = isChanged;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                "only include vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
