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
  GetAvailableRoomsModel({this.roomName,this.rateOfRoom,this.currency,this.adultNum,this.childNum,this.checkOut,this.checkIn,this.roomNum,this.hotelCode});
  factory GetAvailableRoomsModel.fromJson(Map<String,dynamic>json){
    return GetAvailableRoomsModel(
      roomName:json['name'],
      //currency: json['currency'],
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
class CancelPolicies{
  String?amount;
  String?deadTime;
  CancelPolicies({this.amount,this.deadTime});
  factory CancelPolicies.fromJson(Map<String,dynamic>json){
    return CancelPolicies(
      amount: json['amount'],
      deadTime:DateFormat('d MMM y').format(DateTime.parse(json['from'])),
    );
  }
}
class RateOfRoom{
  String?rateCommentId;
  String?net;
  String?paymentType;
  bool packaging;
  List<CancelPolicies>?cancelPolicies;
  RateOfRoom({this.cancelPolicies,this.paymentType,this.packaging=false,this.net,this.rateCommentId});
  factory RateOfRoom.fromJson(Map<String,dynamic>json){
    return RateOfRoom(
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