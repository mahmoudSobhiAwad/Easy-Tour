import 'dart:math';
import 'dart:ui'as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LatLng> decodePolyline(String encodedPolyline) {
  List<LatLng> points = [];
  int index = 0, len = encodedPolyline.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encodedPolyline.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    lat += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

    shift = 0;
    result = 0;
    do {
      b = encodedPolyline.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    lng += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

    points.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return points;
}
Map<String,LatLng> getSouthAndNorthEastBounds(List<LatLng>points){
  double leastLat=points[0].latitude;
  double leastLong=points[0].longitude;
  double mostLat=points[0].latitude;
  double mostLong=points[0].longitude;
  for(var item in points){
    leastLat=min(leastLat, item.latitude);
    leastLong=min(leastLong,item.longitude);
    mostLat=max(mostLat, item.latitude);
    mostLong=max(mostLong,item.longitude);
  }
  return {'southEast':LatLng(leastLat, leastLong),'northEast':LatLng(leastLat, leastLong)};
}
Future<Uint8List>getImageFormRawData(String imagePath,double width)async{
  ByteData imageDate=await rootBundle.load(imagePath);
  var imageCodec=await ui.instantiateImageCodec(imageDate.buffer.asUint8List(),targetWidth:width.round());
  var imageFrame=await imageCodec.getNextFrame();
  var imageByteDate=await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
  return imageByteDate!.buffer.asUint8List();
}