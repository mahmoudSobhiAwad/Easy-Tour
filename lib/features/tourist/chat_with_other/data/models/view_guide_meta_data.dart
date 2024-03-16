import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class ViewGuideMetaDataModel{
  String?profileUrl;
  String?fName;
  String?status;
  String?email;
  String?chatId;
  ViewGuideMetaDataModel({this.status,this.fName,this.profileUrl,this.email,this.chatId});
  factory ViewGuideMetaDataModel.fromJson(Map<String,dynamic>json){
    return ViewGuideMetaDataModel(
      profileUrl: ProfileImageUrl.fromJson(json['profilePicture']).imageUrl??"",
      fName: json['firstName']??"",
      status: json['status']??"offline",
      email: json['email']??"",
      chatId: json['chats'][0]['_id'],
    );
  }
}