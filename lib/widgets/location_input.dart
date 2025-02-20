import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  bool isGettingLocation = false;

  _getCurrentLocation() async {
    setState(() {
      isGettingLocation = true;
    });
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    setState(() {
      isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ? Text(
                    'No location chosen',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  )
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
