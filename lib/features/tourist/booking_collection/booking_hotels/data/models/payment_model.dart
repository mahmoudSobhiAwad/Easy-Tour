class PaxPayModel{
  String rateKey;
  String?roomName;
  String?cancelPrice;
  String?deadTime;
  String?boardName;
  int adultNum;
  int childNum;
  PaxInPayment? onePaxModel;
  PaxPayModel({required this.rateKey,this.roomName,this.deadTime,this.boardName,this.cancelPrice,this.adultNum=1,this.childNum=0,this.onePaxModel});
}

class PaymentModel{
  String name;
  String surName;
  List<RoomsInPayment>roomsInPaymentList;
  String email;
  String phone;
  String?remark;
  String?clientRef;
  String?creditCardName;
  String?cardNumber;
  String?expiryDate;
  String?securityCode;
  String?cardType;
  PaymentModel({required this.surName,this.clientRef,
    required this.name,
    required this.roomsInPaymentList,required this.email,
    required this.phone,this.remark,
    this.securityCode,
    this.expiryDate,
    this.cardNumber,
    this.cardType,
    this.creditCardName,
  });
  Map<String,dynamic>toJson(){
    return {
      "holder": {
        "name": name,
        "surname": surName,
      },
      "rooms":List.generate(roomsInPaymentList.length, (index) => RoomsInPayment(rateKey: roomsInPaymentList[index].rateKey).toJson()),
      "clientReference":clientRef??"No Client",
      "remark": remark??"",
    };
  }
  Map<String,dynamic>withCreditToJson(){
    return {
      "holder": {
        "name": name,
        "surname": surName,
      },
      "rooms":List.generate(roomsInPaymentList.length, (index) => RoomsInPayment(rateKey: roomsInPaymentList[index].rateKey).toJson()),
      "clientReference":clientRef??"No Client",
      "remark": remark??"",
      "paymentData": {
        "paymentCard": {
          "cardHolderName": creditCardName,
          "cardType": cardType,
          "cardNumber": cardNumber,
          "expiryDate": expiryDate,
          "cardCVC": securityCode,
        },
        "contactData": {
          "email": email,
          "phoneNumber": phone,
        }
      }
    };
  }

}
class RoomsInPayment{
  String rateKey;
  //List<PaxInPayment> paxInPaymentList;
  RoomsInPayment({required this.rateKey,});
  Map<String,dynamic>toJson(){
    return {
      'rateKey':rateKey,
    };
  }

}
class PaxInPayment{
  String type;
  String name;

  PaxInPayment({required this.type,required this.name,});
  Map<String,dynamic>toJson(){
    return {
      "type": type,
      "name": name,
    };
  }
}