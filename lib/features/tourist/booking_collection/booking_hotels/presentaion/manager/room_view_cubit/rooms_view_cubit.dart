import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/room_view_cubit/rooms_view_states.dart';

class RoomsViewCubit extends Cubit<RoomsViewState>{
  RoomsViewCubit({required this.availableRoomsList,required this.paxList,required this.totalRoomNum}):super(InitialRoomsViewState());
  List<String>facilityStringList=[];
  List<GetAvailableRoomsModel> availableRoomsList;
  List<GetAvailableRoomsModel> bookedRoomList=[];
  int totalRoomNum;
  List<OccupanciesModel>paxList;
  double totalNet=0;
  int totalPickedRoom=0;
  Future<void> loadFacilityFromLocal(BuildContext context,HotelsModel model)async{
    emit(LoadingFacilityDataState());
    DefaultAssetBundle.of(context).loadString('assets/hotels/facilities.json').then((value){
      var response=json.decode(value);
      for (var item in model.facilitiesList??[]){
        for(var element in response['facilities']){
          if(item.facilityGroupCode==element['facilityGroupCode']&&item.facilityCode==element['code']){
            facilityStringList.add(element['description']['content']);
            break;
          }
        }
      }
      emit(SuccessFacilityDataState());
    }).catchError((e){
      emit(FailureFacilityDataState(errMessage: e.toString()));
    });
  }
  void changeRoomBookedNumbers({required int index,required bool increase}){
    if(increase){
      if(totalRoomNum!=totalPickedRoom)
      {
        int allotment = availableRoomsList[index].rateOfRoom![0].allotment ?? 5;
        if (availableRoomsList[index].rateOfRoom![0].bookedNum < allotment) {
          availableRoomsList[index].rateOfRoom![0].bookedNum++;
          totalNet+=double.parse(availableRoomsList[index].rateOfRoom?[0].net??"0").roundToDouble();
          totalPickedRoom++;
        } else {
          emit(FailureIncreaseRoomNumState(
              errMessage: "The Allotment Rooms is full"));
        }
      }
      else{
        emit(FailureIncreaseRoomNumState(
            errMessage: "The Allotment Rooms is full"));
      }
    }
    else{
      if(availableRoomsList[index].rateOfRoom![0].bookedNum >0){
        availableRoomsList[index].rateOfRoom![0].bookedNum --;
        totalNet-=double.parse(availableRoomsList[index].rateOfRoom?[0].net??"0").roundToDouble();
        totalPickedRoom--;
      }
    }
    emit(ChangeNumOfBookedRoom());
  }
  void getListOfPickedRoom(){
    bookedRoomList.clear();
    for(var item in availableRoomsList){
      if(item.rateOfRoom!.first.bookedNum>0){
        int counter=item.rateOfRoom!.first.bookedNum;
        for(int i=0;i<counter;i++){
          bookedRoomList.add(item);
        }
      }
    }
    for(int i=0;i<totalRoomNum;i++){
      bookedRoomList[i].occupanciesList=[];
      bookedRoomList[i].occupanciesList?.add(paxList[i]);
    }
    emit(InitNeededRoomsList(rooms: bookedRoomList));

  }
}