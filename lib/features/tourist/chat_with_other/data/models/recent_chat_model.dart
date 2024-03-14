import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class RecentChatModel{
  PersonInChatData?personOne;
  PersonInChatData?personTwo;
  String?chatId;
  OneMessageModel?oneMessage;
  RecentChatModel({this.chatId,this.personOne,this.personTwo,this.oneMessage});
  factory RecentChatModel.fromJson(Map<String,dynamic>json){
    return RecentChatModel(
      personOne: PersonInChatData.fromJson(json['POne']),
      personTwo: PersonInChatData.fromJson(json['PTwo']),
      chatId: json['_id'],
      oneMessage: OneMessageModel.fromJson(json['messages'][0]),
    );
  }
}
class PersonInChatData{
  String?profilePic;
  String?name;
  String?email;
  PersonInChatData({this.profilePic,this.name,this.email});
  factory PersonInChatData.fromJson(Map<String,dynamic>json)=>PersonInChatData(
    profilePic: ProfileImageUrl.fromJson(json['image']).imageUrl??"",
    email: json['email'],
    name: json['name'],

  );
}
class OneMessageModel{
  String?message;
  String?fromPerson;
  String?toPerson;
  bool?sent;
  DateTime?messageDate;
  String?type;
  OneMessageModel({this.fromPerson,this.messageDate,this.toPerson,this.message,this.sent,this.type});
  factory OneMessageModel.fromJson(Map<String,dynamic>json){
    return OneMessageModel(
        message: json['message'],
        toPerson: json['to'],
        fromPerson: json['from'],
        messageDate: DateTime.parse(json['date']),
      );
  }
}