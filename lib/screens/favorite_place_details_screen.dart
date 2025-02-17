import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class FavoritePlaceDetailsScreen extends StatelessWidget {
  const FavoritePlaceDetailsScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place details'),
      ),
      body: Center(
        child:
            Text(place.tittle, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
