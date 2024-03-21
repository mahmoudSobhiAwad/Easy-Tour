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

class Place{
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

  factory Place.fromJson(Map<String, dynamic> json, int i) {
    return Place(
      name: json['place${i + 1}'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      activity: json['activity'],
      category: json['category'],
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