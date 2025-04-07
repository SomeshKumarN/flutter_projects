import 'package:fav_places_app/model/place.dart';
import 'package:riverpod/riverpod.dart';

class UserPlacesProvider extends StateNotifier<List<Place>> {
  UserPlacesProvider() : super([]);

  void addPlace(Place place) {
    state = [...state, place];
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
