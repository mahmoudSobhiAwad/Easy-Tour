import 'package:dio/dio.dart';
import 'dart:io';
class TouristInfoModel {
  String?phoneNumber;
  String?languages;
  String?gender;
  String?status;
  String?nationality;
  bool?confirmedEmail;
  List?preferences;
  String?profileUrl;
  String?coverUrl;
  File?profileFile;
  File?coverFile;
  String?flagName;
  TouristInfoModel({this.profileUrl,this.flagName,this.coverUrl,this.coverFile,this.profileFile,this.preferences,this.confirmedEmail,this.phoneNumber,this.gender,this.languages,this.nationality,this.status});
  factory TouristInfoModel.fromJson(Map<String,dynamic>json)=> TouristInfoModel(
    languages: json['language'],
    profileUrl:  ProfileImageUrl.fromJson(json['profilePicture']).imageUrl??'',
    coverUrl: ProfileImageUrl.fromJson(json['coverPicture']).imageUrl??'',
    gender: json['gender']??"male",
    status: json['status'],
    nationality: json['country']??'Egypt',
    confirmedEmail: json['confirmed']??false,
    phoneNumber: json['phoneNumber']??"",
    preferences: json['preferences']??[''],
    flagName: json['countryFlag']??'',
  );
   Future<FormData> toFormData() async{
     FormData formData = FormData.fromMap({
       'profilePicture':profileFile!=null?[await MultipartFile.fromFile(profileFile?.path??"",filename: 'Profile Picture')]:[],
       'coverPicture':coverFile!=null?[await MultipartFile.fromFile(coverFile?.path??"",filename: 'Cover Picture')]:[],
       'language': languages,
       'phoneNumber': phoneNumber,
       'gender': gender,
       'preferences': preferences,
       'country': nationality,
       'countryFlag':flagName,
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
