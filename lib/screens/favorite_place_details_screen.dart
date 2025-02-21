import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/map_sreen.dart';
import 'package:flutter/material.dart';

class FavoritePlaceDetailsScreen extends StatelessWidget {
  const FavoritePlaceDetailsScreen({super.key, required this.place});

  final Place place;

  _onOpeningMapAvatar(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapSreen(
            location: place.location,
            isSelecingLocation: false,
          ),
        ));
  }

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
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              spacing: 5,
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(place.location.imageURL),
                  ),
                  onTap: () => _onOpeningMapAvatar(context),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
