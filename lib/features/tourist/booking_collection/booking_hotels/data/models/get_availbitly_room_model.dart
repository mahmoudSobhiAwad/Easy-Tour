import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';

class GetAvailableRoomsModel{
  String? roomName;
  String?currency;
  String?checkIn;
  String?checkOut;
  int?hotelCode;
  List<OccupanciesModel>?occupanciesList=[];
  List<RateOfRoom>?rateOfRoom;
  // List<PaxModel>?paxList;

  GetAvailableRoomsModel({this.roomName,this.rateOfRoom,this.occupanciesList,this.currency,this.checkOut,this.checkIn,this.hotelCode});
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
        ...List.generate(occupanciesList?.length??0, (index) {
          return OccupanciesModel(
            childNum: occupanciesList?[index].childNum??0,
            adultNum: occupanciesList?[index].adultNum??0,
            paxList: occupanciesList?[index].childNum==0?[]:occupanciesList?[index].paxList??[],
          ).toJson();
        }),

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
  String?boardName;
  List<CancelPolicies>?cancelPolicies;
  RateOfRoom({this.cancelPolicies,this.bookedNum=0,this.boardName,this.paymentType,this.allotment,this.packaging=false,this.net,this.rateCommentId,required this.rateKey});
  factory RateOfRoom.fromJson(Map<String,dynamic>json){
    return RateOfRoom(
      boardName: json['boardName'],
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

class OccupanciesModel{
  int childNum;
  int adultNum;
  List<PaxModel>?paxList;
  OccupanciesModel({this.adultNum=0,this.childNum=0,this.paxList});
  Map<String,dynamic>toJson(){
    return {
      "rooms": 1,
      "adults": adultNum,
      "children": childNum,
      "paxes":childNum!=0?[
        ...List.generate(childNum, (index) {
          return {
            'type':'CH',
            'age':paxList?[index].age,
          };
        })
      ]:null,
    };
  }
}