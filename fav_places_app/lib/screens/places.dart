import 'package:fav_places_app/providers/user_places_provider.dart';
import 'package:fav_places_app/screens/add_place.dart';
import 'package:fav_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorite Places!'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddPlaceScreen();
              }));
            },
          ),
        ],
      ),
      body: PlacesList(place: userPlaces),
    );
  }
}
