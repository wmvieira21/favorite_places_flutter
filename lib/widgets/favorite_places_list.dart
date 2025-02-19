import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/provider/favorite_places_provider.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/favorite_place_details_screen.dart';

class FavoritePlacesList extends ConsumerStatefulWidget {
  const FavoritePlacesList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FavoritePlacesList();
  }
}

class _FavoritePlacesList extends ConsumerState<FavoritePlacesList> {
  _buildFavoritePlace(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritePlaceDetailsScreen(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Place> favoritePlacesList = ref.watch(favoritePlacesProvider);

    if (favoritePlacesList.isEmpty) {
      return Center(
        child: Text(
          'No places added yet.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }
    return ListView.builder(
      itemCount: favoritePlacesList.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(favoritePlacesList[index].image),
              ),
              title: Text(favoritePlacesList[index].tittle),
              onTap: () => _buildFavoritePlace(favoritePlacesList[index]),
            ));
      },
    );
  }
}
