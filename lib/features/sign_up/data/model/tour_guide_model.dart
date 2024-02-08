import 'package:dio/dio.dart';

class TourGuideSignUpModel{
  String?nIdUrl;
  String?tourismId;
  String?firstName;
  String?lastName;
  String?address;
  List<String>?lang;
  String?date;
  String?phoneNum;
  String?describe;
  String?email;
  String?password;
  String?token;
  String?profileUrl;
  String?confirmPassword;
  bool ?confirmAcc;
  TourGuideSignUpModel({
    this.token,
    this.profileUrl,
    required this.email,
    this.password,
    this.confirmPassword,
    this.lastName,
    this.nIdUrl,
    this.phoneNum,
    this.tourismId,
    this.address,
    this.date,
    this.lang,
    this.describe,
    this.firstName,
    this.confirmAcc,
  });
  Future<FormData> toFormData() async{
    FormData formData = FormData.fromMap({
      'syndicateID':await MultipartFile.fromFile(nIdUrl!,filename: 'syndicateID'),
      'ministryID':await MultipartFile.fromFile(tourismId!,filename: 'ministryID'),
      'firstName': firstName,
      'description':describe,
      'lastName': lastName,
      'phoneNumber':phoneNum,
      'languages':lang?.toList(),
      'address': address,
      'email':email,
      'password':password,
      'confirmPassword':confirmPassword,
      'birthDate':date,
      'profilePicture':profileUrl!=null?await MultipartFile.fromFile(profileUrl!,filename: 'profilePicture'):[],
    });
    return formData;
  }
  factory TourGuideSignUpModel.fromJson(Map<String,dynamic>json)=>TourGuideSignUpModel(
    token: json['token'],
    email: json['email'],
    lastName:json['lastName'],
    firstName: json['firstName'],
    confirmAcc: json['confirmed']??false,
    profileUrl:GetImageUrl.fromJson(json['profilePicture']).imageUrl??'',
  );

}
class GetImageUrl{
  String?imageUrl;
  GetImageUrl({this.imageUrl,});
  factory GetImageUrl.fromJson(Map<String,dynamic>? json)=>GetImageUrl
    (
      imageUrl: json?['secure_url']
  );
}