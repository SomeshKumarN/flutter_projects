import 'package:fav_places_app/model/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceDetailScreen extends ConsumerWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;

  String get locationImage {
    final lat = place.location!.latitude;
    final lng = place.location!.longitude;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$lng&key=AIzaSyDLBJnS20lorFgYez-Llus_EcuHmf4vc2Q";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(locationImage),
                    ),
                    Text(
                      place.location!.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ))
          ],
        ));
  }
}
