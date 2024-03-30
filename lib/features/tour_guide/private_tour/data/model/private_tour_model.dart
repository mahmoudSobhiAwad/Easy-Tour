import 'package:dio/dio.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
class Trip {
  String? title;
  String? brief;
  num? maximumNumber;
  List<TripDay>? tripDetails;
  List<dynamic>? included;
  List<dynamic>? excluded;
  String?bgImagePath;
  String?tripId;
  Map<String,dynamic>?tripTicket;
  String?guidePic;
  String?guideEmail;
  Trip({
    this.title,
    this.brief,
    this.maximumNumber,
    this.tripDetails,
    this.bgImagePath,
    this.tripId,
    this.tripTicket,
    this.included,
    this.excluded,
    this.guidePic,
    this.guideEmail,
  });

  factory Trip.fromJson(Map<String, dynamic> ?json) {
    return Trip(
      tripId: json?['id']??"",
      bgImagePath:ProfileImageUrl.fromJson(json?['image']).imageUrl??"",
      guideEmail: TourGuideOfTheTripInfo.fromJson(json?['createdBy']).email,
      guidePic: TourGuideOfTheTripInfo.fromJson(json?['createdBy']).profilePic??"",
      title: json?['title']??'',
      brief: json?['brief']??'',
      included: json?['included']??[],
      excluded: json?['excluded']??[],
      tripTicket: json?['plans']??{},
      maximumNumber: json?['maximumNumber']??0,
      tripDetails: (json?['tripDetails']as List).map((dayData) => TripDay.fromJson(dayData)).toList(),
    );
  }
  Future<FormData>toFormData()async{
    FormData formData=FormData.fromMap({
      'title':title,
      "brief":brief,
      "maximumNumber":maximumNumber,
      "plans":tripTicket,
      "included":included,
      "excluded":excluded,
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
      "included":included,
      "excluded":excluded,
      "maximumNumber":maximumNumber,
      "plans":tripTicket,
      'newTripDetails':tripDetails?.map((tripDetails) => tripDetails.toJson()).toList(),
      'image':bgImagePath!=null?[await MultipartFile.fromFile(bgImagePath!,filename: 'background image')]:[]
    });
  return formData;
  }
}

class TripDay
{
  String? dayName;
  List<TripPlace>? dayPlaces;

  TripDay({
    this.dayName,
    this.dayPlaces,
  });

  factory TripDay.fromJson(Map<String,dynamic> json) {
    return TripDay(
      dayName: json['dayName']??'',
      dayPlaces: (json['dayPlaces']as List).map((placeData) => TripPlace.fromJson(placeData)).toList(),
    );
  }
  Map<String,dynamic>toJson()=>{
    'dayName':dayName,
    'dayPlaces':dayPlaces?.map((day) => day.toJson()).toList(),
  };
}

class TripPlace {
  String? placeName;
  String? placeType;
  String?typeImageUrl;
  String? longitude;
  String? latitude;
  String? activity;

  TripPlace({
    this.placeName,
    this.placeType,
    this.longitude,
    this.latitude,
    this.activity,
    this.typeImageUrl,
  });

  factory TripPlace.fromJson(Map<String, dynamic> json) {
    return TripPlace(
      placeName: json['placeName']??'' ,
      placeType: json['placeType']??'',
      longitude: json['longitude']??'',
      latitude: json['latitude']??'',
      activity: json['activity'] ??'',
      typeImageUrl: getImageUrlFromType(json['placeType'])
    );
  }
  Map<String,dynamic>toJson()=>{
    'placeName':placeName,
    'placeType':placeType,
    'activity':activity,
  };
}
class TourGuideOfTheTripInfo{
  String?profilePic;
  String?email;
  TourGuideOfTheTripInfo({this.email,this.profilePic});
  factory TourGuideOfTheTripInfo.fromJson(dynamic json){
    if(json is String){
      return TourGuideOfTheTripInfo(
        email: null,
        profilePic:null,
      );
    }
    else{
      return TourGuideOfTheTripInfo(
        email: json?['email'],
        profilePic:ProfileImageUrl.fromJson(json?['profilePicture']).imageUrl??"",
      );
    }

    }
  }
class ProfileImageUrl{
  String?imageUrl;
  ProfileImageUrl({this.imageUrl,});
  factory ProfileImageUrl.fromJson(Map<String,dynamic>?json)=>ProfileImageUrl(
      imageUrl: json?['secure_url']
  );
}
String getImageUrlFromType(String?type){
  switch(type){
    case 'Historical and Cultural Tours':return historicalPlace;
    case 'Nile River Cruises':return nileRiver;
    case 'Desert Adventures':return desertAdventures;
    case 'Beach and Red Sea Resorts':return beaches;
    case 'Religious and Pilgrimage Trips':return religiousPlaces;
    case 'Food and Culinary Tours':return foodPlaces;
    default:return defaultImage;
  }
}