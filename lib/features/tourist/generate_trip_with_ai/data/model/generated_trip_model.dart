import 'package:intl/intl.dart';

class GeneratedTripModel {
  final List<Day> days;
  final List<String>placesNames;
  final String? startDate;
  final String? endDate;
  final String? title;
  final String?id;
  final int?durationNum;

  const GeneratedTripModel({required this.days,required this.placesNames,this.title,this.endDate,this.startDate,this.id,this.durationNum});

  factory GeneratedTripModel.fromJson(Map<String,dynamic> json) {
    List<Day>day=[];
    List<String>placesNames=[];
    for(int i=0;i<json.length;i++)
    {
      String jsonKey='Day${i+1}';
      placesNames.add(json[jsonKey]['governorate']??"");
      day.add(Day.fromJson(json[jsonKey]['places']));
    }
    return GeneratedTripModel(
      days:day,
      placesNames: placesNames,
    );
  }

  factory GeneratedTripModel.fromHistory(Map<String,dynamic> json) {
    return GeneratedTripModel(
      days:[],
      id: json['_id'],
      durationNum:(json['to']!=null||json['from']!=null)?DateFormat("dd MMM yyyy").parse(json['to']).difference(DateFormat("dd MMM yyyy").parse(json['from'])).inDays:null,
      startDate: json['from'],
      endDate: json['to'],
      title: json['title'],
      placesNames: [],
    );
  }


}

class Day {
  final List<Place> places;


  const Day({required this.places});

  factory Day.fromJson(List<dynamic> json){
    List<Place>places=[];
    for(int i=0;i<json.length;i++){
      places.add(Place.fromJson(json[i]));
    }
    return Day(
      places:places,
    );
  }
  factory Day.fromHistory(List<dynamic> json){
    List<Place>places=[];
    for(int i=0;i<json.length;i++){
      places.add(Place.fromHistory(json[i]));
    }
    return Day(
      places:places,
    );
  }
}

class Place{
  final String name;
  final double longitude;
  final double latitude;
  final String activity;
  final String category;
  final num?budget;
  final String?time;
  final String?image;
  bool picked;

   Place({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.activity,
    required this.category,
    required this.image,
    required this.time,
    required this.budget,
    this.picked=false,
  });

  factory Place.fromJson(Map<String, dynamic> json,) {
    return Place(
      name: json['placeName']??"",
      longitude:json['longitude'],
      latitude: json['latitude'],
      activity: json['activity']??"",
      category: json['category']??"",
      budget: json['budget']??0,
      image: json['image_link']??"",
      time: json['time']??"",
    );
  }

  factory Place.fromJsonSecond(Map<String, dynamic> json) {
    return Place(
      name: json['place']??"",
      longitude: json['longitude']??0.0,
      latitude: json['latitude']??0.0,
      activity: json['activity']??"",
      category: json['category']??"",
      budget: json['budget']??0,
      image: json['image_link']??"",
      time: json['time']??"",
    );
  }
  factory Place.fromHistory(Map<String, dynamic> json) {
    return Place(
      name: "",
      longitude:double.parse(json['longitude'].toString()).toDouble(),
      latitude: double.parse(json['latitude'].toString()).toDouble(),
      activity: json['activity']??"",
      category: json['category']??"",
      budget:5.50,
      image: "s",
      time: "s",
    );
  }

  factory Place.fromCustomTripJson(Map<String,dynamic>json){
    return Place(
      name: json['placeName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      category: json['category'],
      image: json['image'],
      activity: json['activity'],
      time: '',
      budget:json['priceRange'],
    );
  }


  Map<String,dynamic>toCustomTripJson(){
    return {
      "placeName": name,
      "latitude": latitude,
      "longitude": longitude,
      "category": "Cultural Centers",
      "image": image,
      "activity": activity,
      "priceRange": budget,
      "government":"Cairo"
    };
  }

}