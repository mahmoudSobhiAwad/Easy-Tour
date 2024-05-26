import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_state.dart';

class HotelBookingCubit extends Cubit<HotelBookingStates>{
  HotelBookingCubit({required this.hotelsRepoImpl,this.hotelList,this.checkIn='checkIn',this.checkOut='CheckOut',this.childNum=0,this.roomNum=0,this.adultNum=0,}):super(InitialHotelBookingState());
  TextEditingController searchText=TextEditingController();
  List<String> searchResults = [];
  Timer?debounce;
  final formatter = DateFormat('yyyy-MM-dd');
  String checkIn;
  String checkOut;
  int adultNum;
  int childNum;
  int roomNum;
  List<HotelsModel>?hotelList=[];
  DestinationModel?destModel;
  String destName='';
  final GetHotelsRepoImpl hotelsRepoImpl;
  late HotelModelWithRoomModel hotelModelWithRoomModel;
  bool showList=false;
  void searchForSpecificDest(){
    searchResults = [];
    if(searchText.text.isNotEmpty&&searchText.text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
        debounce=Timer(const Duration(milliseconds: 250), () async{
          for(var item in destList){
            if(item.destName.toLowerCase().contains(searchText.text.toLowerCase())){
              searchResults.add(item.destName);
            }
          }
          searchResults.isNotEmpty? showList=true:showList=false;
          emit(CompleteTextSearchForDestination());
        }
        );
      }
    }
  }
  void onTapOnMenu(String result){
    searchText.text=result;
    destModel=destList.where((element) => element.destName==searchText.text).first;
    showList=false;
    emit(CompleteTextSearchForDestination());
  }
  void getRangeDate(BuildContext context)async{
    DateTimeRange? dateTimeRange= await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      saveText: 'Pick',
    );

    if(dateTimeRange!=null)
    {
     checkIn=formatter.format(dateTimeRange.start);
      checkOut=formatter.format(dateTimeRange.end);
    }
    emit(ChangeCheckInCheckOutDate());

  }
  void changeAdultOrChildOrRoomNum({required int index, required bool add}){
    if(index==0){
      if(add){
        adultNum++;
      }
      else{
        if(adultNum>0){
          adultNum--;
        }
      }
    }
    else if(index==1){
      if(add){
        childNum++;
      }
      else{
        if(childNum>0){
          childNum--;
        }
      }
    }
    else if(index==2){
      if(add){
        roomNum++;
      }
      else{
        if(roomNum>0){
          roomNum--;
        }
      }
    }
    emit(ChangeAdultOrChildrenOrRoomNumber());
  }
  void searchForHotelsByDestOnly(DestinationModel model)async{
    destName=model.destName;
    emit(LoadingGetHotelsState());
    var result=await hotelsRepoImpl.getAllHotelsInDestination(destCode:model.destCode);
    result.fold((failure){
      emit(FailureGetHotelsState(errMessage:failure.errMessage ));
      debugPrint(failure.errMessage);
    }, (hotels){
      hotelList=[];
      for(var item in hotels){
        hotelList!.add(item);
      }
      emit(SuccessGetHotelsState());
    });
  }
  void searchForAvailableRooms({required int hotelCode,required int hotelIndex})async{
    emit(LoadingGetAvailableRooms());
    var result=await hotelsRepoImpl.getAvailableRooms(toJsonModel: GetAvailableRoomsModel(
      adultNum: adultNum,
      childNum: childNum,
      roomNum: roomNum,
      checkIn: checkIn,
      checkOut: checkOut,
      hotelCode: hotelCode,
    ).toJson());
    result.fold((failure) {
      emit(FailureGetAvailableRooms(errMessage: failure.errMessage));
      print(failure.errMessage);
    }, (availableRooms) {
      if(availableRooms.isEmpty){
        emit(FailureGetAvailableRooms(errMessage: 'there is no available rooms'));
      }
      else{
      hotelModelWithRoomModel=HotelModelWithRoomModel(availableRoomsModel: availableRooms, hotelsModel: hotelList![hotelIndex]);
      emit(SuccessGetAvailableRooms(model: hotelModelWithRoomModel));
      }
    } );
  }
}

