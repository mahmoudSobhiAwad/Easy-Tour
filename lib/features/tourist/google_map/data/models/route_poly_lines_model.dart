class RoutePolyLinesModel{
  num?distanceInMeters;
  String?duration;
  PolyLineModel?polyLineModel;
  RoutePolyLinesModel({this.duration,this.distanceInMeters,this.polyLineModel});
  factory RoutePolyLinesModel.fromJson(Map<String,dynamic>json){
    return RoutePolyLinesModel(
      distanceInMeters: json['distanceMeters'],
      duration: json['duration'],
      polyLineModel: PolyLineModel.fromJson(json['polyline']),
    );
  }
  Map<String,dynamic>toJson({required OriginOrDestinationModel origin,required OriginOrDestinationModel destination}){
    return
      {
        "origin":origin.toJson(),
        "destination":destination.toJson(),
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "computeAlternativeRoutes": false,
        "routeModifiers": {
          "avoidTolls": false,
          "avoidHighways": false,
          "avoidFerries": false
        },
        "languageCode": "en-US",
        "units": "IMPERIAL"
    };
  }
}
class PolyLineModel{
  String?encodedPolyLine;
  PolyLineModel({this.encodedPolyLine});
  factory PolyLineModel.fromJson(Map<String,dynamic>json){
    return PolyLineModel(
      encodedPolyLine: json['encodedPolyline']
    );
  }
}
class OriginOrDestinationModel{
  double?latitude;
  double?longitude;
  OriginOrDestinationModel({this.longitude,this.latitude});
  Map<String,dynamic>toJson(){
    return {
      "location":{
        "latLng":{
          "latitude":latitude,
          "longitude": longitude,
        }
      }
    };
  }
}