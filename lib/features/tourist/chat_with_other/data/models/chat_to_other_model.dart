class ChatToOtherModel{
  String? message;
  DateTime? dateTime;
  String? type;
  bool?sent;
  ChatToOtherModel({ this.message, this.sent, this.type, this.dateTime});
  factory ChatToOtherModel.fromJson(Map<String,dynamic>json){
    return ChatToOtherModel(
        message: json['message'],
        sent: json['sent'],
        type: json['type'],
        dateTime: json['dateTime']
    );
  }
  Map<String,dynamic>toJson(){
    return {
      'message':message,
      'dateTime':dateTime,
      'type':type,
    };
  }
}