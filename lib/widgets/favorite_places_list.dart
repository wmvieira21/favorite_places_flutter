import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class FavoritePlacesList extends StatefulWidget {
  const FavoritePlacesList({super.key});
  @override
  State<StatefulWidget> createState() {
    return _FavoritePlacesList();
  }
}

class _FavoritePlacesList extends State<FavoritePlacesList> {
  List<Place> _places = [];

  @override
  Widget build(BuildContext context) {
    if (_places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }
    return Center();
  }
}
