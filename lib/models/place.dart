import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  PlaceLocation(
      {required this.latitude,
      required this.longitude,
      required this.address,
      required this.imageURL});

  final double latitude;
  final double longitude;
  final String address;
  final String imageURL;
}

class Place {
  Place(
      {required this.tittle,
      required this.image,
      required this.location,
      String? id})
      : id = id ?? uuid.v4();

  final String id;
  final String tittle;
  final File image;
  final PlaceLocation location;
}
