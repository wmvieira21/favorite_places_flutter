import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/provider/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesList extends ConsumerStatefulWidget {
  const FavoritePlacesList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FavoritePlacesList();
  }
}

class _FavoritePlacesList extends ConsumerState<FavoritePlacesList> {
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
          padding: EdgeInsets.all(16),
          child: Text(
            favoritePlacesList[index].tittle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        );
      },
    );
  }
}
