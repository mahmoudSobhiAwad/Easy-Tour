import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';

class GetAvailableRoomsModel{
  String? roomName;
  String?currency;
  String?checkIn;
  String?checkOut;
  int?roomNum;
  int?adultNum;
  int?childNum;
  int?hotelCode;
  List<RateOfRoom>?rateOfRoom;
  List<PaxModel>?paxList;
  GetAvailableRoomsModel({this.roomName,this.rateOfRoom,this.paxList,this.currency,this.adultNum,this.childNum,this.checkOut,this.checkIn,this.roomNum,this.hotelCode});
  factory GetAvailableRoomsModel.fromJson(Map<String,dynamic>json){
    return GetAvailableRoomsModel(
      roomName:json['name'],
      currency: json['currency'],
      rateOfRoom: List<RateOfRoom>.from(json['rates'].map((x) => RateOfRoom.fromJson(x))),
    );
  }
  Map<String,dynamic>toJson(){
    return {
      "stay": {
        "checkIn": checkIn,
        "checkOut": checkOut
      },
      "occupancies": [
        {
          "rooms": roomNum,
          "adults": adultNum,
          "children": childNum,
          "paxes":paxList!=null?[
            ...List.generate(paxList?.length??0, (index) {
              return {
                'type':paxList?[index].type,
                'age':paxList?[index].age,
              };
            })
          ]:null,
        }
      ],
      "hotels": {
        "hotel": [
          hotelCode,
        ]
      }
    };
  }
}
Map<String,dynamic>?getPax(List<PaxModel>?paxList){
  if(paxList!=null){
    Map<String,dynamic>paxMap={};
    for(var item in paxList){
      paxMap.addAll({'age':item.age,'type':'CH'});
    }
    return paxMap;
  }
  return null;
}
class CancelPolicies{
  String?amount;
  String?deadTime;
  CancelPolicies({this.amount,this.deadTime});
  factory CancelPolicies.fromJson(Map<String,dynamic>json){
    return CancelPolicies(
      amount: json['amount'],
      deadTime:DateFormat('dd MMM HH:mm').format(DateTime.parse(json['from'])),
    );
  }
}
class RateOfRoom{
  String?rateCommentId;
  String?net;
  String?paymentType;
  bool packaging;
  String rateKey;
  int? allotment;
  int bookedNum;
  List<CancelPolicies>?cancelPolicies;
  RateOfRoom({this.cancelPolicies,this.bookedNum=0,this.paymentType,this.allotment,this.packaging=false,this.net,this.rateCommentId,required this.rateKey});
  factory RateOfRoom.fromJson(Map<String,dynamic>json){
    return RateOfRoom(
      allotment: json['allotment'],
      rateKey: json['rateKey'],
      rateCommentId: json['rateCommentsId'],
      net: json['net'],
      paymentType: json['paymentType'],
      packaging: json['packaging'],
      cancelPolicies:List<CancelPolicies>.from(json['cancellationPolicies'].map((x) => CancelPolicies.fromJson(x))),
    );
  }
}
class HotelModelWithRoomModel{
  HotelsModel hotelsModel;
  List<GetAvailableRoomsModel> availableRoomsModel;
  HotelModelWithRoomModel({required this.availableRoomsModel,required this.hotelsModel});
}