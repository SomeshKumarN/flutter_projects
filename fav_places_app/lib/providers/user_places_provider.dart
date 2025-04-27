import 'dart:io';

import 'package:fav_places_app/model/place.dart';
import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite/sqlite_api.dart';

class UserPlacesProvider extends StateNotifier<List<Place>> {
  UserPlacesProvider() : super([]);

  Future<Database> _getDatabase() async {
    final dbPath = await path_provider.getApplicationDocumentsDirectory();
    return sqflite.openDatabase(
      '${dbPath.path}/places.db',
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, imagePath TEXT, lat TEXT, lng TEXT, address TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('places');
    state = maps.map((map) {
      return Place(
        id: map['id'],
        title: map['title'],
        image: File(map['imagePath']),
        location: PlaceLocation(
          latitude: double.parse(map['lat']),
          longitude: double.parse(map['lng']),
          address: map['address'],
        ),
      );
    }).toList();
  }

  void addPlace(Place place) async {
    final imagePath = await path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final newImage = await place.image.copy('${imagePath.path}/$fileName');

    final newPlace = Place(
        title: place.title,
        image: newImage,
        location: place.location); // Update the place with the new image path
    // Save the image to the new path (this is just a placeholder, implement actual saving logic)

    final db = await _getDatabase();
    db.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'imagePath': newPlace.image.path,
        'lat': newPlace.location!.latitude,
        'lng': newPlace.location!.longitude,
        'address': newPlace.location!.address,
      },
    );
    state = [...state, newPlace];
  }

  void removePlace(Place place) {
    state = state.where((p) => p != place).toList();
  }

  void updatePlace(Place oldPlace, Place newPlace) {
    state = state.map((p) => p == oldPlace ? newPlace : p).toList();
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlacesProvider, List<Place>>((ref) {
  return UserPlacesProvider();
});
