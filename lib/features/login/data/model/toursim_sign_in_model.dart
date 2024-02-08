import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';

class TourismSignInModel
{
  final String?email;
  final String?password;
  final String?token;
  final String?name;
  final String?profileUrl;
  bool?confirm;
  TourismSignInModel({required this.email, this.password,this.token,this.name,this.profileUrl,this.confirm});
  Map<String,dynamic>toJson()=>{
    'email':email,
    'password':password,
  };
  factory TourismSignInModel.getInfoFromJson(Map<String,dynamic>?json)=>TourismSignInModel(
    email:json?['email']??"",
    name:json?['userName']??"",
    token:json?['token']??"",
    confirm:json?['confirmed']??"",
    profileUrl: ProfileImageUrl.fromJson(json?['profilePicture']).imageUrl,
  );

}
class TourismResetPassModel{
  final String?token;
  final String?resetCode;
  final String?message;
  TourismResetPassModel({this.resetCode,this.token,this.message});
  factory TourismResetPassModel.fromJson(Map<String,dynamic>json)=>TourismResetPassModel(
    resetCode: json['resetCode'],//resetCode
    token:json['token'], );
  factory TourismResetPassModel.successMessage(Map<String,dynamic>json)=>TourismResetPassModel(
    message: json['message'],//resetCode
     );
}