import 'package:favorite_places/services/google_maps_service.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/widgets/map_sreen.dart';
import 'package:favorite_places/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.selectedLocationMap});
  final Function(PlaceLocation location) selectedLocationMap;

  @override
  State<StatefulWidget> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  GoogleMapsService mapService = GoogleMapsService();
  PlaceLocation? pickedLocation;
  String _currentLocation = 'No location chosen';
  bool isGettingLocation = false;

  _getCurrentLocation() async {
    setState(() {
      isGettingLocation = true;
    });

    pickedLocation = await mapService.getCurrentLocation();

    if (pickedLocation != null) {
      setState(() {
        _currentLocation = pickedLocation!.address;
        isGettingLocation = false;
      });
      widget.selectedLocationMap(pickedLocation!);
    }
  }

  _onSelectingLocationMap() async {
    pickedLocation = pickedLocation ?? await mapService.getCurrentLocation();

    LatLng? selectedLatLngOnMap =
        await Navigator.of(context).push<LatLng?>(MaterialPageRoute(
      builder: (context) =>
          MapSreen(location: pickedLocation!, isSelecingLocation: true),
    ));
    if (selectedLatLngOnMap != null) {
      PlaceLocation newPlaceLocation = await mapService.getPlaceLocation(
          selectedLatLngOnMap.latitude, selectedLatLngOnMap.longitude);

      setState(() {
        pickedLocation = newPlaceLocation;
      });
      widget.selectedLocationMap(pickedLocation!);
    }
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
              onPressed: () => _onSelectingLocationMap(),
            ),
          ],
        )
      ],
    );
  }
}
