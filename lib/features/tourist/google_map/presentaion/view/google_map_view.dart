import 'dart:ui'as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  Set<Marker>markers={};
  @override
  void initState(){
    initialCameraPosition =const CameraPosition(target:LatLng(29.97416777 ,31.1339477975),);
    createMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoogleMap(
        markers: markers,
          initialCameraPosition: initialCameraPosition,
      ),
    );
  }
  void createMarkers()async{
    BitmapDescriptor icons= BitmapDescriptor.fromBytes(await getImageFormRawData('assets/gen_trip_images/islamic.png', 200));
    Set<Marker> myMarkers= placeMapModelList.map((placeModel) {
     return  Marker(
         icon:icons,
         markerId: MarkerId(placeModel.id!),infoWindow: InfoWindow(title:placeModel.name),position: placeModel.latLng!);
     },
   ).toSet();
   markers.addAll(myMarkers);
   setState(() {

   });
  }
}

class PlaceMapModel{
  String?id;
  String?name;
  LatLng?latLng;
  String?iconName;
  PlaceMapModel({this.latLng,this.name,this.id,this.iconName});
}
List<PlaceMapModel>placeMapModelList=[
  PlaceMapModel(id: '1',name: 'Pyramids',latLng: const LatLng(30.593758, 32.269860),iconName: 'assets/gen_trip_images/safari.jpg'),
  PlaceMapModel(id: '2',name: 'Egyptian Museum ',latLng: const LatLng(30.619222, 31.732507),iconName: 'assets/gen_trip_images/islamic.png'),
  PlaceMapModel(id: '3',name: 'Karnak Temple ',latLng: const LatLng(25.722175, 32.660821),iconName: 'assets/gen_trip_images/safari.png'),
];
Future<Uint8List>getImageFormRawData(String imagePath,double width)async{
  ByteData imageDate=await rootBundle.load(imagePath);
  var imageCodec=await ui.instantiateImageCodec(imageDate.buffer.asUint8List(),targetWidth:width.round());
  var imageFrame=await imageCodec.getNextFrame();
  var imageByteDate=await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
  return imageByteDate!.buffer.asUint8List();
}