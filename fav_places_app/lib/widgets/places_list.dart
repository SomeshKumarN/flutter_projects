import 'package:fav_places_app/model/place.dart';
import 'package:fav_places_app/screens/place_details.dart';
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
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(place[index].image),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              place[index].location!.address,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PlaceDetailScreen(place: place[index]);
              }));
            },
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
