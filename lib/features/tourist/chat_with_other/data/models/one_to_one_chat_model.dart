import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';

class GetOTOChatModel{
  PersonInChatData?personOne;
  PersonInChatData?personTwo;
  String?chatId;
  List<OneMessageModel>?messagesList;
  GetOTOChatModel({this.personTwo,this.personOne,this.messagesList,this.chatId});
  factory GetOTOChatModel.fromJson(Map<String,dynamic>json){
    return GetOTOChatModel(
      personOne: PersonInChatData.fromJson(json['POne']),
      personTwo: PersonInChatData.fromJson(json['PTwo']),
      chatId: json['_id'],
      messagesList: (json['messages'] as List).map((oneMessage) =>OneMessageModel.fromJson(oneMessage)).toList(),
    );
  }
}
class SendOTOMessageModel{
  String?contentMessage;
  String?desID;
  SendOTOMessageModel({required this.desID,required this.contentMessage});

  Map<String,dynamic>toJson(){
    return {
      "message": contentMessage,
      "destEmail": desID,
    };
  }
}