class SendFcmModel{
  String?fcmDevice;
  String?enable;
  SendFcmModel({this.enable,this.fcmDevice});
  Map<String,dynamic>toJson(){
    return {
      'pushToken':fcmDevice,
      'enable':enable,
    };
  }
}