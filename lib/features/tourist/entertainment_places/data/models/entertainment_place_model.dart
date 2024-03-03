import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';

class EntertainmentPlacesModel{
  List<PlaceOfEntertainment>?entertainmentPlacesList;
  EntertainmentPlacesModel({this.entertainmentPlacesList});
  factory EntertainmentPlacesModel.fromJson(Map<String,dynamic>json){
    List<PlaceOfEntertainment>list=[];
    for(int i=0;i<json.length;i++){
      list.add(PlaceOfEntertainment.fromJson(json['data'][i]));
    }
    return EntertainmentPlacesModel(
      entertainmentPlacesList: list,
    );
  }
}
class LocationEntertainmentModel{
  double? longitude;
  double? latitude;
  LocationEntertainmentModel({this.latitude,this.longitude});
  factory LocationEntertainmentModel.fromJson(Map<String,dynamic>json)=>LocationEntertainmentModel(
    latitude: json['latitude']??0,
    longitude:json['longitude']??0,
  );
}
class PlaceOfEntertainment{
  LocationEntertainmentModel? placeLocation;
  String? imageUrl;
  String?id;
  String?name;
  String?type;
  String?details;
  num?ticketPrice;
  PlaceOfEntertainment({
    this.imageUrl,this.type,this.name,this.id,this.details,this.ticketPrice,this.placeLocation,
});
  factory PlaceOfEntertainment.fromJson(Map<String,dynamic>json)=>PlaceOfEntertainment(
    imageUrl: ProfileImageUrl.fromJson(json['image']).imageUrl,
    placeLocation: LocationEntertainmentModel.fromJson(json['location']),
    id:json['_id']??'',
    name: json['name']??'',
    type: json['type']??'',
    details: json['details']??'',
    ticketPrice: json['ticket_price']??0,
  );
}