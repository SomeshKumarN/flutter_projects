import 'package:fav_places_app/model/place.dart';
import 'package:riverpod/riverpod.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;

class UserPlacesProvider extends StateNotifier<List<Place>> {
  UserPlacesProvider() : super([]);

  void addPlace(Place place) async {
    final imagePath = await path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(place.image.path);
    final newImage = await place.image.copy('${imagePath.path}/$fileName');

    final newPlace = Place(
        title: place.title,
        image: newImage,
        location: place.location); // Update the place with the new image path
    // Save the image to the new path (this is just a placeholder, implement actual saving logic)
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
