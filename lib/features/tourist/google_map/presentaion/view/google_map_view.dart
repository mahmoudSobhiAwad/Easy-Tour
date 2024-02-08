import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(29.97416777 ,31.1339477975)));
  }
}
