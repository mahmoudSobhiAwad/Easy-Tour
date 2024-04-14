import 'dart:convert';

import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/destination_with_number_model.dart';

class TypeOfTourism{
  String typeImage;
  String typeName;
  bool picked;
  TypeOfTourism({required this.typeImage,required this.typeName,required this.picked});
}
class RequestTripModel{
  List<String>?preferred;
  List<DestinationPlaceDayModel>?governments;
  double? lat;
  double? long;
  int? numOfPlaceInDay;
  int? numOfDay;
  RequestTripModel({this.numOfDay,this.governments,this.long,this.numOfPlaceInDay,this.preferred,this.lat});
  toJsonEncode(){
    var data = json.encode({
      "prefered": preferred,
      "Government": governments,
      "latitude": lat,
      "longitude": long,
      "noday": numOfDay,
      "no_of_places": numOfPlaceInDay,
    });
    return data;
  }
}




