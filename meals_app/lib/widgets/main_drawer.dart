import 'package:flutter/material.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});
  final Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Row(
            children: [
              Icon(
                Icons.fastfood,
                size: 48,
              ),
              SizedBox(
                width: 18,
              ),
              Text(
                "Cooking Up!",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.restaurant),
          title: Text(
            "Meals",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 24),
          ),
          onTap: () {
            onSelectScreen("meals");
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            "Filter",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 24),
          ),
          onTap: () {
            onSelectScreen("filters");
          },
        )
      ]),
    );
  }
}
