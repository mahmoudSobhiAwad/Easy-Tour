class PaxPayModel{
  String rateKey;
  String?roomName;
  String?cancelPrice;
  String?deadTime;
  String?boardName;
  int adultNum;
  int childNum;
  List<OnePaxModel>? paxList;
  PaxPayModel({required this.rateKey,this.roomName,this.deadTime,this.boardName,this.cancelPrice,this.adultNum=1,this.childNum=0,this.paxList});
}
class OnePaxModel{
  String firstName;
  String surName;
  String type;
  int roomId;
  OnePaxModel({required this.surName,required this.type,required this.firstName,required this.roomId});
}
class PaymentModel{
  String name;
  String surName;
  List<RoomsInPayment>roomsInPaymentList;
  String email;
  String phone;
  String?remark;
  String?clientRef;
  PaymentModel({required this.surName,this.clientRef,required this.name,required this.roomsInPaymentList,required this.email,required this.phone,this.remark});
  Map<String,dynamic>toJson(){
    return {
      "holder": {
        "name": name,
        "surname": surName,
      },
      "rooms":roomsInPaymentList,
      "clientReference":clientRef??"No Client",
      "remark": remark??"",
    };
  }

}
class RoomsInPayment{
  String rateKey;
  List<PaxInPayment>paxInPaymentList;
  RoomsInPayment({required this.rateKey,required this.paxInPaymentList});
  Map<String,dynamic>toJson(){
    return {
      'rateKey':rateKey,
      'paxes':paxInPaymentList,
    };
  }

}
class PaxInPayment{
  int roomId;
  String type;
  String name;
  String surName;
  PaxInPayment({required this.type,required this.name,required this.roomId,required this.surName});
  Map<String,dynamic>toJson(){
    return {
      "roomId": roomId,
      "type": type,
      "name": name,
      "surname": surName,
    };
  }
}