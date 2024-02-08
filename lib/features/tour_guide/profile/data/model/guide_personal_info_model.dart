import 'package:dio/dio.dart';

class TourGuidePersonalInfoModel{
  String? firstName;
  String? lastName;
  String? address;
  String? describeText;
  String? date;
  String? phoneNumber;
  String? profileUrl;
  String?minId;
  String?profileFile;
  String?synId;
  List<dynamic> ?lang;
  Map<String,dynamic>?contactInfo;
  TourGuidePersonalInfoModel({ this.date,this.profileFile,this.describeText, this.firstName, this.lastName, this.address,this.profileUrl, this.lang,this.phoneNumber,this.minId,this.synId,this.contactInfo,});
  factory TourGuidePersonalInfoModel.fromJson(Map<String,dynamic>json)=>TourGuidePersonalInfoModel(
     firstName: json['firstName'],
     date: json['birthDate'],
     lastName: json['lastName'],
    describeText: json['description'],
     address: json['address']??"",
     profileUrl:ProfileImageUrl.fromJson(json['profilePicture']).imageUrl??"",
      minId: ProfileImageUrl.fromJson(json['ministyliscence']).imageUrl??"",
      synId: ProfileImageUrl.fromJson(json['syndicateLiscence']).imageUrl??"",
     lang: json['languages']??[],
     phoneNumber: json['phoneNumber'],
      contactInfo:json['contact_info']
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
  // Future<FormData>updateContactInfo(Map<String,String>contact)async{
  //   FormData formData=FormData.fromMap({
  //     'contactInfo':contact,
  //   });
  //   return formData;
  // }
}
class ProfileImageUrl{
  String?imageUrl;
  ProfileImageUrl({this.imageUrl,});
  factory ProfileImageUrl.fromJson(Map<String,dynamic>?json)=>ProfileImageUrl
    (
      imageUrl: json?['secure_url']
  );

}
