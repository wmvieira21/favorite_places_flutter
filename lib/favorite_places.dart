import 'package:favorite_places/provider/favorite_places_provider.dart';
import 'package:favorite_places/screens/add_new_place_screen.dart';
import 'package:favorite_places/widgets/favorite_places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaces extends ConsumerStatefulWidget {
  const FavoritePlaces({super.key});

  @override
  ConsumerState<FavoritePlaces> createState() {
    return _FavoritePlaces();
  }
}

class _FavoritePlaces extends ConsumerState<FavoritePlaces> {
  late Future<void> places;

  @override
  void initState() {
    places = ref.read(favoritePlacesProvider.notifier).loadPlaces();
  }

  _addFavoritePlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNewPlaceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton.outlined(
            icon: const Icon(Icons.add),
            onPressed: () => _addFavoritePlace(context),
          )
        ],
      ),
      body: FutureBuilder(
          future: places,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return FavoritePlacesList();
            }
            return Center(
              child: Text('An error has occured while loading data'),
            );
          }),
    );
  }
}
