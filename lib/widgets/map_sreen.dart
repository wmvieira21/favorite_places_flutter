import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSreen extends StatefulWidget {
  const MapSreen(
      {super.key, required this.location, required this.isSelecingLocation});

  final PlaceLocation location;
  final bool isSelecingLocation;

  @override
  State<StatefulWidget> createState() {
    return _MapScreen();
  }
}

class _MapScreen extends State<MapSreen> {
  LatLng? _pickedlocation;

  @override
  Widget build(BuildContext context) {
    LatLng latLng = LatLng(widget.location.latitude, widget.location.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isSelecingLocation ? 'Pick your location' : 'Your location'),
        actions: [
          if (widget.isSelecingLocation)
            IconButton(
              onPressed: () {
                Navigator.pop(context, _pickedlocation);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 18,
        ),
        markers: (_pickedlocation == null && widget.isSelecingLocation)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedlocation ?? latLng,
                ),
              },
        onTap: (args) {
          if (widget.isSelecingLocation) {
            setState(() {
              _pickedlocation = args;
            });
          }
        },
      ),
    );
  }
}
