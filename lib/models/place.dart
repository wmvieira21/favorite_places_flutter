import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place(this.tittle, this.image, this.location) : id = uuid.v4();

  final String id;
  final String tittle;
  final File image;
  final PlaceLocation location;
}
