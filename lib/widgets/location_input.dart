import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favorite_places/models/place.dart';

const apiKey = "AIzaSyDFB2WLqjpKNCXyrCHXa8nPtztK5stB8go";

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.selectedLocationMap});
  final Function(PlaceLocation location) selectedLocationMap;

  @override
  State<StatefulWidget> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  String _currentLocation = 'No location chosen';
  bool isGettingLocation = false;

  String locationImageURL(double latitude, double longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=17&size=600x200&markers=color:purple%7Clabel:A%7C$latitude,$longitude&key=$apiKey";
  }

  _getCurrentLocation() async {
    setState(() {
      isGettingLocation = true;
    });

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
    _getLocationGoogleMaps(locationData.latitude!, locationData.longitude!);
  }

  _getLocationGoogleMaps(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');
    http.Response response = await http.get(url);
    final data = jsonDecode(response.body);

    setState(() {
      _currentLocation = data['results'][0]['formatted_address'];
      isGettingLocation = false;
    });

    pickedLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: _currentLocation,
      imageURL: locationImageURL(latitude, longitude),
    );

    widget.selectedLocationMap(pickedLocation!);
  }

  Widget get getLocationContainerPreview {
    return (pickedLocation == null
        ? Text(_currentLocation,
            maxLines: 5,
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
            textAlign: TextAlign.center)
        : Image.network(
            pickedLocation!.imageURL,
            fit: BoxFit.cover,
            height: 300,
          ));
  }

  @override
  Widget build(BuildContext context) {
    final imageContainerPreview = getLocationContainerPreview;

    return Column(
      spacing: 10,
      children: [
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 230)),
          ),
          child: Center(
            child: !isGettingLocation
                ? imageContainerPreview
                : const CircularProgressIndicator(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: Theme.of(context).textButtonTheme.style!.copyWith(),
              icon: const Icon(Icons.location_on),
              label: const Text("Current location"),
              onPressed: () => _getCurrentLocation(),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Map"),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
