class TextSearchModel{
  String?address;
  num?rating;
  String?displayName;
  bool?openNow;
  ResultedLocationModel?locationModel;
  TextSearchModel({
    this.address,
    this.rating,
    this.displayName,
    this.locationModel,
    this.openNow,
});
  factory TextSearchModel.fromJson(Map<String,dynamic>json){
   return TextSearchModel(
     openNow: json['regularOpeningHours']?['openNow']??false,
     address: json['shortFormattedAddress'],
     rating: json['rating'],
     displayName: json['displayName']['text'],
     locationModel: ResultedLocationModel.fromJson(json['location']),
   );
  }
}
class ResultedLocationModel{
  double?long;
  double?lat;
  ResultedLocationModel({
    this.long,
    this.lat,
});
 factory ResultedLocationModel.fromJson(Map<String,dynamic>json){
    return ResultedLocationModel(
      lat: json['latitude'],
      long: json['longitude'],
    );
  }
}