import 'package:favorite_places/models/place.dart';
import 'package:riverpod/riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super([]);

  void addFavoritePlace(Place place) {
    state = [...state, place];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>(
        (ref) => FavoritePlacesNotifier());
