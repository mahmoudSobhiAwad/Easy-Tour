import 'package:prepare_project/features/tourist/nearby_places/data/models/photos_models.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/review_model.dart';

class NearbyPlacesModel{
  String?name;
  String?id;
  String?nationalPhoneNum;
  String?internationalPhoneNum;
  String?address;
  double?rating;
  String?displayName;
  String?displayType;
  String?primaryType;
  List<PhotosModel>?photosList;
  List<ReviewModel>?reviewsList;
  NearbyPlacesModel({
    required this.name,
    required this.id,
    this.address,
    this.reviewsList,
    this.photosList,
    this.displayName,
    this.displayType,
    this.internationalPhoneNum,
    this.nationalPhoneNum,
    this.rating,
    this.primaryType
});
  factory NearbyPlacesModel.fromJson(Map<String,dynamic>json){
    return NearbyPlacesModel(
      name: json['name'],
      id: json['id'],
      address: json['formattedAddress'],
      reviewsList: (json['reviews']as List).map((review) => ReviewModel.fromJson(review)).toList(),
      photosList: (json['photos']as List).map((photo) => PhotosModel.fromJson(photo)).toList(),
      internationalPhoneNum: json['internationalPhoneNumber'],
      nationalPhoneNum: json['nationalPhoneNumber'],
      rating: json['rating'],
      displayName: json['displayName']['text'],
      displayType: json['primaryTypeDisplayName']['text'],
      primaryType: json['primaryType'],
    );
  }
  Map<String,dynamic>toJson({String?type,int?maxResult,double? lat,double? long,double? distance}){
    return {
      "includedTypes": [type],
      "maxResultCount": maxResult??10,
      "locationRestriction": {
        "circle":
        {
          "center":
          {
            "latitude":lat?? 37.7937,
            "longitude":long?? -122.3965
          },
          "radius":distance?? 500.0
        }
      }
    };
  }
}
