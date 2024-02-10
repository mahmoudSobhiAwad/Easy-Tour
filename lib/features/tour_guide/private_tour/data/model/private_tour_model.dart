import 'package:dio/dio.dart';
class Trip {
  String? title;
  String? brief;
  num? ticketPerPerson;
  num? minimumNumber;
  List<TripDay>? tripDetails;
  String?bgImagePath;
  String?tripId;
  Trip({
    this.title,
    this.brief,
    this.ticketPerPerson,
    this.minimumNumber,
    this.tripDetails,
    this.bgImagePath,
    this.tripId,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: json['id']??"",
      bgImagePath:ProfileImageUrl.fromJson(json['image']).imageUrl??"",
      title: json['title']??'',
      brief: json['brief']??'',
      ticketPerPerson: json['ticketPerPerson']??0,
      minimumNumber: json['minimumNumber']??0,
      tripDetails: (json['tripDetails']as List).map((dayData) => TripDay.fromJson(dayData)).toList(),
    );
  }
  Future<FormData>toFormData()async{
    FormData formData=FormData.fromMap({
      'title':title,
      "brief":brief,
      "ticketPerPerson":ticketPerPerson,
      "minimumNumber":minimumNumber,
      'tripDetails':tripDetails?.map((tripDetails) => tripDetails.toJson()).toList(),
      'image':bgImagePath!=null?[await MultipartFile.fromFile(bgImagePath!,filename: 'background image')]:[]
    });
  return formData;
  }
  Future<FormData>updateTrip()async{
    FormData formData=FormData.fromMap({
      'trip_id':tripId,
      'title':title,
      "brief":brief,
      "ticketPerPerson":ticketPerPerson,
      "minimumNumber":minimumNumber,
      'newTripDetails':tripDetails?.map((tripDetails) => tripDetails.toJson()).toList(),
      'image':bgImagePath!=null?[await MultipartFile.fromFile(bgImagePath!,filename: 'background image')]:[]
    });
  return formData;
  }
}

class TripDay
{
  String? dayName;
  List<Place>? dayPlaces;

  TripDay({
    this.dayName,
    this.dayPlaces,
  });

  factory TripDay.fromJson(Map<String,dynamic> json) {
    return TripDay(
      dayName: json['dayName']??'',
      dayPlaces: (json['dayPlaces']as List).map((placeData) => Place.fromJson(placeData)).toList(),
    );
  }
  Map<String,dynamic>toJson()=>{
    'dayName':dayName,
    'dayPlaces':dayPlaces?.map((day) => day.toJson()).toList(),
  };
}

class Place {
  String? placeName;
  String? placeType;
  String? longitude;
  String? latitude;
  String? activity;

  Place({
    this.placeName,
    this.placeType,
    this.longitude,
    this.latitude,
    this.activity,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeName: json['placeName']??'' ,
      placeType: json['placeType'] ??'',
      longitude: json['longitude'] ??'',
      latitude: json['latitude']??'',
      activity: json['activity'] ??'',
    );
  }
  Map<String,dynamic>toJson()=>{
    'placeName':placeName,
    'placeType':placeType,
    'activity':activity,
  };
}
class ProfileImageUrl{
  String?imageUrl;
  ProfileImageUrl({this.imageUrl,});
  factory ProfileImageUrl.fromJson(Map<String,dynamic>?json)=>ProfileImageUrl(
      imageUrl: json?['secure_url']
  );
}
