import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class FavoritePlaceDetailsScreen extends StatelessWidget {
  const FavoritePlaceDetailsScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.tittle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(spacing: 20, children: [
          Text(place.tittle, style: Theme.of(context).textTheme.titleMedium),
          Image.file(
            place.image,
            fit: BoxFit.fill,
            width: double.infinity,
            height: 300,
          ),
        ]),
      ),
    );
  }
}
