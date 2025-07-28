import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 14,
        ),
        onTap: (LatLng pos) async {
          setState(() {
            selectedLocation = pos;
          });

          List<Placemark> placemarks = await placemarkFromCoordinates(
            pos.latitude,
            pos.longitude,
          );
          String address = placemarks.first.street ?? 'Picked Location';

          Navigator.pop(context, address);
        },
        markers:
            selectedLocation != null
                ? {
                  Marker(
                    markerId: MarkerId("picked"),
                    position: selectedLocation!,
                  ),
                }
                : {},
      ),
    );
  }
}
