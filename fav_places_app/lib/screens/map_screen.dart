import 'package:fav_places_app/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.place});
  final Place place;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.place.location!.latitude,
                widget.place.location!.longitude),
            zoom: 16),
        markers: {
          Marker(
            visible: true,
            markerId: const MarkerId('m1'),
            position: LatLng(widget.place.location!.latitude,
                widget.place.location!.longitude),
          )
        },
      ),
    );
  }
}
