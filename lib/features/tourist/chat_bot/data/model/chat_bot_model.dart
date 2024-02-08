class ChatBotModel{
  String?message;
  DateTime?messageDateTime;
  bool sent;
  ChatBotModel({required this.message,this.messageDateTime,this.sent=false});
  factory ChatBotModel.fromJson(Map<String,dynamic>json){
    return ChatBotModel(
      message: json['response'],
    );
  }
 Map<String ,dynamic> toJson(){
    return {
      'prompt':message,
    };
 }
}