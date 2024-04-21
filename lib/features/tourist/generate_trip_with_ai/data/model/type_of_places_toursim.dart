import 'dart:convert';


class TypeOfTourism{
  String typeImage;
  String typeName;
  bool picked;
  TypeOfTourism({required this.typeImage,required this.typeName,required this.picked});
}
class RequestTripModel{
  List<String>?preferred;
  Map<String,int>?governments;
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
      "no_of_places": numOfPlaceInDay,
    });
    return data;
  }
}




