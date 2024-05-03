class GeneratedTripModel {
  final List<Day> days;
  final List<String>placesNames;

  const GeneratedTripModel({required this.days,required this.placesNames});

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

class Place{
  final String name;
  final double longitude;
  final double latitude;
  final String activity;
  final String category;
  final num?budget;
  final String?time;
  final String?image;

  const Place({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.activity,
    required this.category,
    required this.image,
    required this.time,
    required this.budget,
  });

  factory Place.fromJson(Map<String, dynamic> json, int i) {
    return Place(
      name: json['place${i + 1}']??"",
      longitude: json['longitude']??0,
      latitude: json['latitude']??0,
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
      longitude: json['longitude']??0,
      latitude: json['latitude']??0,
      activity: json['activity']??"",
      category: json['category']??"",
      budget: json['budget']??0,
      image: json['image_link']??"",
      time: json['time']??"",
    );
  }

  Map<String, dynamic> toJson(int i) =>
      {
        "place${i + 1}": name,
        "longitude": longitude,
        "latitude": latitude,
        "activity": activity,
        "category": category,
      };

}