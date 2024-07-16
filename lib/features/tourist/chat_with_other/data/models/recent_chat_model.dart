import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class RecentChatModel{
  PersonInChatData?personOne;
  PersonInChatData?personTwo;
  String?chatId;
  CompleteChatOTOModel?oneMessage;
  RecentChatModel({this.chatId,this.personOne,this.personTwo,this.oneMessage});
  factory RecentChatModel.fromJson(Map<String,dynamic>json){
    return RecentChatModel(
      personOne: PersonInChatData.fromJson(json['POne']),
      personTwo: PersonInChatData.fromJson(json['PTwo']),
      chatId: json['_id'],
      oneMessage: CompleteChatOTOModel.fromJson(json['messages'][0]),
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

class RecordModel{
  String?recordPath;
  double?currentPosition;
  double?totalDuration;
  bool isPlaying;
  bool isLoading;
  RecordModel({this.currentPosition=0,this.totalDuration=0,this.recordPath,this.isPlaying=false,this.isLoading=true});
}

class CompleteChatOTOModel{
  String?message;
  String?fromPerson;
  String?toPerson;
  String?type;
  String?messageType;
  RecordModel?recordModel;
  ImageModel?imageModel;
  DateTime?messageDate;
  LatLng?locationMessage;
  bool?isLoading;
  CompleteChatOTOModel({this.message,this.messageType,this.fromPerson,this.locationMessage,this.isLoading=true,this.toPerson,this.messageDate,this.imageModel,this.recordModel,this.type});
  factory CompleteChatOTOModel.fromJson(Map<String,dynamic>json){
    return CompleteChatOTOModel(
      message: json['message'],
      messageType: json['type'],
      toPerson: json['to'],
      fromPerson: json['from'],
      messageDate: DateTime.parse(json['date']),
      recordModel: json['type']=='voice'?RecordModel(recordPath: json['message'],isLoading: false):RecordModel(),
      imageModel: json['type']=='image'?ImageModel(imageNetworkPath: json['message'],isLoading: false):ImageModel(),
      locationMessage: json['type']=='video'?getLocation(json['message']):LatLng(0, 0),
      type:checkType(json['from']),
    );
  }
}
class ImageModel{
  String?filePath;
  String?description;
  String?imageNetworkPath;
  bool isLoading;
  ImageModel({this.filePath,this.imageNetworkPath,this.isLoading=true,this.description});
}
String checkType(String value){
  final String sourceEmail=SetAppState.prefs?.getString('email')??"";
  if(value==sourceEmail){
    return 'source';
  }
  else{
    return 'destination';
  }
}

class LocationModel{
  double? lat;
  double? long;
  LocationModel({this.long,this.lat});



}
LatLng getLocation(String input){
  RegExp longExp = RegExp(r'long=([\d.]+)');
  RegExp latExp = RegExp(r'lat=([\d.]+)');

  // Extract the values using the regular expressions
  double? longitude;
  double? latitude;

  Match? longMatch = longExp.firstMatch(input);
  Match? latMatch = latExp.firstMatch(input);

  if (longMatch != null && latMatch != null) {
  longitude = double.tryParse(longMatch.group(1)!);
  latitude = double.tryParse(latMatch.group(1)!);
  }
  return LatLng(latitude??0, longitude??0);
}