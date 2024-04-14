class GeneratedTripModel {
  final List<Day> days;
  final String dayInPlace;

  const GeneratedTripModel({required this.days,required this.dayInPlace});

  factory GeneratedTripModel.fromJson(Map<String,dynamic> json) {
    List<Day>day=[];
    for(int i=0;i<json.length;i++)
    {
      String jsonKey='Day${i+1}';
      day.add(Day.fromJson(json[jsonKey]['places']));
    }
    return GeneratedTripModel(
      days:day,
      dayInPlace: json['governorate']
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
  final String?budget;
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
      name: json['place${i + 1}'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      activity: json['activity'],
      category: json['category'],
      budget: json['budget'],
      image: json['image_link'],
      time: json['time'],
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