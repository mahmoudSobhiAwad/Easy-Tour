import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/manager/map_cubit/google_map_states.dart';
import 'dart:ui'as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapCubit extends Cubit<GoogleMapStates>{
  GoogleMapCubit():super(InitialGoogleMapState());
  Set<Marker>markers={};
  bool enableMyLocation=false;
  // void initPolylines() {
  //   Polyline polyline=const Polyline(
  //       width: 5,
  //       //patterns: [PatternItem.dot],//if i need to make the line dash or dot
  //       //jointType: JointType.bevel,
  //       color: closeColor,
  //       endCap: Cap.squareCap,
  //       polylineId: PolylineId('1'),
  //       points: [
  //         LatLng(30.593758, 32.269860 ),//p1
  //         LatLng(30.619222, 31.732507),//p2
  //         LatLng(25.722175, 32.660821),//p3
  //         //then we have path from p1 to p2 ,p2 t0 p3
  //         // we have 2 paths
  //       ]);
  //   polylinesSet.add(polyline);
  // }
  //
  // void initPolygons() {
  //   Polygon polygon= Polygon(
  //       strokeColor: secondaryColor,
  //       strokeWidth: 5,
  //       fillColor: basicColor.withOpacity(0.5),
  //       polygonId:const PolygonId('2'),
  //       points:const [
  //         LatLng(31.26743684451587, 32.29128411905518),
  //         LatLng(30.62618266658708, 32.312937747608856),
  //         LatLng(29.999208001492406, 32.55381230865813),
  //         LatLng(27.76825761929716, 34.20065647702483),
  //         LatLng(28.5091769835955, 34.52074652089606),
  //         LatLng(29.51687440623645, 34.85684106696086),
  //         LatLng(31.33679802957941, 34.21442304059874),
  //       ],
  //       holes: const [
  //         [
  //           LatLng(28.688793001245692, 33.67247122100762),
  //           LatLng(28.469460334373508, 33.890214984499494),
  //           LatLng(28.76733561662578, 34.30038678445752),
  //         ],//hole 1
  //       ]
  //   );
  //   polygonSet.add(polygon);
  // }
  //
  // void initCircles() {
  //   Circle realMadrid= Circle(
  //       radius: 1000,
  //       strokeColor: forthColor,
  //       fillColor: goldenColor.withOpacity(0.3),
  //       circleId:const CircleId('1'),center:const LatLng(40.453079066668025, -3.688285805372625));
  //   circlesSet.add(realMadrid);
  // }
  Future<bool>askToEnableLocationServices()async{
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled)
    {
      emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.' ));
      return false;
    }
    else{
      return true;
    }
  }
  Future<bool>askToEnableMyLocation()async{
    LocationPermission permission;
    if(await askToEnableLocationServices()){
      permission = await Geolocator.checkPermission();
      if(permission==LocationPermission.deniedForever){
        emit(AllowLocationFailedState());
        return false;
      }
      else if (permission == LocationPermission.denied)
      {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always||permission==LocationPermission.whileInUse) {
          emit(AllowLocationSuccessState());
          return true;
        }
        else{
          emit(AllowLocationFailedState());
        return false;
        }
      }
      else{
        return true;
      }
    }
    else{
      emit(AllowLocationFailedState());
    return false;
    }
  }
  Future<void> requestAllowLocation() async {
    if(await askToEnableMyLocation()){
      enableMyLocation=true;
    }
  }

  // void onMapCreated(GoogleMapController controller)
  // {
  //   googleMapController=controller;
  //   emit(InitialCameraPositionSuccessState());
  // }
}
Future<Uint8List>getImageFormRawData(String imagePath,double width)async{
  ByteData imageDate=await rootBundle.load(imagePath);
  var imageCodec=await ui.instantiateImageCodec(imageDate.buffer.asUint8List(),targetWidth:width.round());
  var imageFrame=await imageCodec.getNextFrame();
  var imageByteDate=await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
  return imageByteDate!.buffer.asUint8List();
}