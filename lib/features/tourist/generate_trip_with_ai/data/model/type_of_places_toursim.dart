import 'dart:convert';

class TypeOfTourism{
  String typeImage;
  String typeName;
  bool picked;
  TypeOfTourism({required this.typeImage,required this.typeName,required this.picked});
}
class RequestTripModel{
  List<String>?preferred;
  List<String>?governments;
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

class GeneratedTripModel {
  final List<Day> days;

  const GeneratedTripModel({required this.days});

  factory GeneratedTripModel.fromJson(Map<String,dynamic> json) {
    List<Day>day=[];
    for(int i=0;i<json.length;i++){
      String jsonKey='Day${i+1}';
      day.add(Day.fromJson(json[jsonKey]));
    }
    return GeneratedTripModel(
      days:day,
    );
  }
}

class Day {
  final List<Place> places;

  const Day({required this.places});

  factory Day.fromJson(List<dynamic> json){
    List<Place>places=[];
    for(int i=0;i<json.length;i++){
      places.add(Place.fromJson(json[i],i));
    }
    return Day(
      places:places,
    );
  }
}

class Place {
  final String name;
  final double longitude;
  final double latitude;
  final String activity;
  final String category;

  const Place({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.activity,
    required this.category,
  });

  factory Place.fromJson(Map<String, dynamic> json,int i) {
    return Place(
      name: json['place${i+1}'], // handle missing place name
      longitude: json['longitude'],
      latitude: json['latitude'],
      activity: json['activity'],
      category: json['category'],
    );
  }
}


