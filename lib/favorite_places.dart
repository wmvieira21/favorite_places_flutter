import 'package:favorite_places/widgets/favorite_places_list.dart';
import 'package:flutter/material.dart';

class FavoritePlaces extends StatelessWidget {
  const FavoritePlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton.outlined(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FavoritePlacesList(),
    );
  }
}
