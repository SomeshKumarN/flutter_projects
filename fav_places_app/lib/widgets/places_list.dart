import 'package:fav_places_app/model/place.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.place});

  final List<Place> place;

  @override
  Widget build(BuildContext context) {
    if (place.isNotEmpty) {
      return ListView.builder(
        itemCount: place.length,
        itemBuilder: (context, index) {
          final title = place[index].title;
          return ListTile(
            title: Text(title),
          );
        },
      );
    }
    return Center(
      child: Text(
        'No Places Available.',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
