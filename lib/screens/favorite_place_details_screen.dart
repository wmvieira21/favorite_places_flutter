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
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(place.tittle,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(place.location.address,
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
