import 'dart:convert';

import 'package:fav_places_app/model/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool isGettingLocation = false;
  String get locationImage {
    if (_pickedLocation!.latitude == null ||
        _pickedLocation!.longitude == null) {
      return '';
    }

    final lat = _pickedLocation?.latitude;
    final lng = _pickedLocation?.longitude;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$lat,$lng&key=AIzaSyDLBJnS20lorFgYez-Llus_EcuHmf4vc2Q";
  }

  void getCurrentLocation() async {
    Location location = new Location();
    setState(() {
      isGettingLocation = true;
    });

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      return;
    }
    print("Latitude: $latitude, Longitude: $longitude");

    final resData = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyDLBJnS20lorFgYez-Llus_EcuHmf4vc2Q'));

    final address =
        json.decode(resData.body)['results'][0]['formatted_address'];
    print(
        "Address: ${json.decode(resData.body)['results'][0]['formatted_address']}");

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      isGettingLocation = false;
    });
  }

  getAddress(LocationData locationData) async {}

  @override
  Widget build(BuildContext context) {
    Widget displayContent = const Center(
      child: Text(
        "No Location Chosen",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(137, 220, 212, 212),
        ),
      ),
    );

    if (isGettingLocation) {
      displayContent = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_pickedLocation != null) {
      displayContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 170,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text(
              "Error loading map",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(137, 220, 212, 212),
              ),
            ),
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: displayContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: getCurrentLocation,
                label: Text("Get Current Location"),
                icon: Icon(Icons.location_on)),
            TextButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {},
                label: Text("Select on Map"),
                icon: Icon(Icons.map)),
          ],
        ),
      ],
    );
  }
}
