import 'package:prepare_project/features/tourist/nearby_places/data/models/photos_models.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/review_model.dart';

class NearbyPlacesModel{
  String?nationalPhoneNum;
  String?internationalPhoneNum;
  String?address;
  num?rating;
  String?displayName;
  String?displayType;
  String?primaryType;
  bool?openNow;
  String?priceLevel;
  String?websiteUri;
  List<PhotosModel>?photosList;
  List<ReviewModel>?reviewsList;
  NearbyPlacesModel({
    this.address,
    this.openNow,
    this.reviewsList,
    this.photosList,
    this.displayName,
    this.displayType,
    this.internationalPhoneNum,
    this.nationalPhoneNum,
    this.rating,
    this.primaryType,
    this.priceLevel,
    this.websiteUri,
});
  factory NearbyPlacesModel.fromJson(Map<String,dynamic>json){
    return NearbyPlacesModel(
      address: json['shortFormattedAddress'],
      openNow: json['regularOpeningHours']?['openNow']??false,
      reviewsList:json['reviews']!=null?(json['reviews'] as List).map((review) => ReviewModel.fromJson(review)).toList():null,
      photosList:json['photos']!=null?(json['photos'] as List).map((photo) => PhotosModel.fromJson(photo)).toList():null,
      internationalPhoneNum: json['internationalPhoneNumber'],
      nationalPhoneNum: json['nationalPhoneNumber'],
      rating: json['rating'],
      displayName: json['displayName']['text'],
      displayType: json['primaryTypeDisplayName']['text'],
      primaryType: json['primaryType'],
      priceLevel: json['priceLevel'],
      websiteUri: json['websiteUri'],
    );
  }
  Map<String,dynamic>toJson({List<String>?type,int?maxResult,double? lat,double? long,double? distance}){
    return {
      "includedTypes": type,
      "maxResultCount": maxResult??3,
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
