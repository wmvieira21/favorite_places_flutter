import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:favorite_places/models/place.dart';

const apiKey = "AIzaSyDFB2WLqjpKNCXyrCHXa8nPtztK5stB8go";

class GoogleMapsService {
  Future<dynamic> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    return getPlaceLocation(locationData.latitude!, locationData.longitude!);
  }

  Future<PlaceLocation> getPlaceLocation(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');
    http.Response response = await http.get(url);
    final data = jsonDecode(response.body);

    return PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: data['results'][0]['formatted_address'],
      imageURL: _getAddressImageURL(latitude, longitude),
    );
  }

  String _getAddressImageURL(double latitude, double longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=17&size=600x200&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$apiKey";
  }
}
