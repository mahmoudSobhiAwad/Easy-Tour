import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      myLocationButtonEnabled: true,

        onMapCreated:(GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: const CameraPosition(target: LatLng(29.97416777 ,31.1339477975),zoom: 1));
  }
}
