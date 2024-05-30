import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_result_cubit/hotel_result_states.dart';

class HotelResultCubit extends Cubit<HotelResultStates>{
  HotelResultCubit({required this.hotelsRepoImpl,this.totalNum=0,required this.hotelList,required this.destModel}):super(InitialHotelResultState());

  final formatter = DateFormat('yyyy-MM-dd');
  String checkIn='Check In';
  String checkOut='Check Out';
  int adultNum=0;
  int childNum=0;
  int roomNum=0;
  bool showOccupancies=false;
  List<HotelsModel>?hotelList=[];
  DestinationModel destModel;
  List<PaxModel>paxList=[];
  int totalNum;
  ScrollController scrollController=ScrollController();
  int currIndex=0;
  int fromIndex=0;
  int toIndex=10;
  final GetHotelsRepoImpl hotelsRepoImpl;

  late HotelModelWithRoomModel hotelModelWithRoomModel;


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

  void searchForAvailableRooms({required int hotelCode,required int hotelIndex})async{
    emit(LoadingGetAvailableRooms());
    var result=await hotelsRepoImpl.getAvailableRooms(toJsonModel: GetAvailableRoomsModel(
      adultNum: adultNum,
      childNum: childNum,
      roomNum: roomNum,
      checkIn: checkIn,
      checkOut: checkOut,
      hotelCode: hotelCode,
      paxList: paxList,
    ).toJson());
    result.fold((failure) {
      emit(FailureGetAvailableRooms(errMessage: failure.errMessage));
    }, (availableRooms) {
      if(availableRooms.isEmpty){
        hotelModelWithRoomModel=HotelModelWithRoomModel(availableRoomsModel: [], hotelsModel: hotelList![hotelIndex]);
        emit(SuccessGetAvailableRooms(model: hotelModelWithRoomModel));
      }
      else{
        hotelModelWithRoomModel=HotelModelWithRoomModel(availableRoomsModel: availableRooms, hotelsModel: hotelList![hotelIndex]);
        emit(SuccessGetAvailableRooms(model: hotelModelWithRoomModel));
      }
    } );
  }

  void showOrClosePickOccupancies(){
    showOccupancies?showOccupancies=false:showOccupancies=true;
    emit(ShowOccupanciesState());
  }

  void fillPaxList(int index,String val){
    int age=int.parse(val);
    if(paxList.length<=index){
      paxList.add(PaxModel(age: age, type: 'CH'));
    }
    else{
      paxList[index]=PaxModel(age: age, type: 'CH');
    }
  }

  void loadMoreHotels()async{
    if(hotelList!.length<totalNum){
      emit(LoadingGetMoreHotels());
      fromIndex=toIndex+1;
      toIndex+=10;
      var result=await hotelsRepoImpl.getAllHotelsInDestination(destCode: destModel.destCode,from:fromIndex ,to:toIndex);
      result.fold((failure){
        emit(FailureGetMoreHotels(errMessage: failure.errMessage));
      }, (success){
        for(HotelsModel item in success.hotelsList??[]){
          hotelList?.add(item);
        }

        emit(SuccessGetMoreHotels());
      });
    }

  }

}