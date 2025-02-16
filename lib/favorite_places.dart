import 'package:favorite_places/screens/add_new_place_screen.dart';
import 'package:favorite_places/widgets/favorite_places_list.dart';
import 'package:flutter/material.dart';

class FavoritePlaces extends StatelessWidget {
  const FavoritePlaces({super.key});

  _addFavoritePlace(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddNewPlaceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton.outlined(
            onPressed: () => _addFavoritePlace(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FavoritePlacesList(),
    );
  }
}
