import 'package:dio/dio.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class TourGuidePersonalInfoModel{
  String? firstName;
  String? lastName;
  String? address;
  String? describeText;
  String? date;
  String? phoneNumber;
  String? profileUrl;
  String? minId;
  String? profileFile;
  String? cvUrl;
  String? cvFile;
  String? synId;
  String?status;
  List<dynamic>? lang;
  Map<String,dynamic>?contactInfo;
  List<Trip>?trips;
  TourGuidePersonalInfoModel({ this.date,this.status,this.profileFile,this.describeText,this.trips,this.cvUrl,this.cvFile,this.firstName, this.lastName, this.address,this.profileUrl, this.lang,this.phoneNumber,this.minId,this.synId,this.contactInfo,});
  factory TourGuidePersonalInfoModel.fromJson(Map<String,dynamic>json)=>TourGuidePersonalInfoModel(
    firstName: json['firstName'],
    date: json['birthDate'],
    lastName: json['lastName'],
    describeText: json['description'],
    address: json['address']??"",
    status: json['status']??'offline',
    profileUrl:ProfileImageUrl.fromJson(json['profilePicture']).imageUrl??"",
    minId: ProfileImageUrl.fromJson(json['ministyliscence']).imageUrl??"",
    synId: ProfileImageUrl.fromJson(json['syndicateLiscence']).imageUrl??"",
    cvUrl: ProfileImageUrl.fromJson(json['CV']).imageUrl??"",
    lang: json['languages']??[],
    phoneNumber: json['phoneNumber'],
    contactInfo:json['contact_info'],
    trips:json['createdTrips']!=null ?(json['createdTrips'] as List).map((oneTrip) => Trip.fromJson(oneTrip)).toList():[],
  );
  Future<FormData> updateTourGuideInfo() async{
    FormData formData = FormData.fromMap({
      'profilePicture':profileFile!=null?[await MultipartFile.fromFile(profileFile!,filename: 'Profile Picture')]:[],
      'phoneNumber': phoneNumber,
      'firstName':firstName,
      'lastName':lastName,
      'address':address,
      "birthDate": date,
      "description":describeText,
    });
    return formData;
  }
  Future<FormData> updateCvFile() async{
    FormData formData = FormData.fromMap({
      'CV':cvFile!=null?[await MultipartFile.fromFile(cvFile!,filename: 'CV')]:[],
    });
    return formData;
  }
}
class ProfileImageUrl{
  String?imageUrl;
  ProfileImageUrl({this.imageUrl,});
  factory ProfileImageUrl.fromJson(Map<String,dynamic>?json)=>ProfileImageUrl
    (
      imageUrl: json?['secure_url']
  );

}
