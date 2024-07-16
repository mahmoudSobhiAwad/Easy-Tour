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
   int totalAdultNum=0;
   int totalChildNum=0;
  // int childNum=0;
   int roomNum=0;
  bool showOccupancies=false;
  List<HotelsModel>?hotelList=[];
  DestinationModel destModel;
  int totalNum;
  ScrollController scrollController=ScrollController();
  int currIndex=0;
  int fromIndex=0;
  int toIndex=10;
  final GetHotelsRepoImpl hotelsRepoImpl;
  List<OccupanciesModel>occupanciesList=[];
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

  void changeAdultOrChildOrRoomNum({required int index, required bool add,required int occupancyIndex}){
    if(index==0){
      if(add){
        occupanciesList[occupancyIndex].adultNum++;
        totalAdultNum++;
      }
      else{
        if(occupanciesList[occupancyIndex].adultNum>0){
          occupanciesList[occupancyIndex].adultNum--;
          totalAdultNum--;
        }
      }
    }
    else if(index==1){
      if(add){
        List<PaxModel>paxEmpty=[];
        occupanciesList[occupancyIndex].childNum++;
        totalChildNum++;
        occupanciesList[occupancyIndex].paxList=paxEmpty;
        occupanciesList[occupancyIndex].paxList?.add(PaxModel(age: 7, type: 'CH'));
      }
      else{
        if(occupanciesList[occupancyIndex].childNum>0){
          occupanciesList[occupancyIndex].childNum--;
          totalChildNum--;
          occupanciesList[occupancyIndex].paxList?.removeLast();
        }
      }
    }
    emit(ChangeAdultOrChildrenOrRoomNumber());
  }

  void searchForAvailableRooms({required int hotelCode,required int hotelIndex})async{
    if(totalAdultNum!=0&&checkIn!="Check In"&&checkOut!='Check Out'){
      emit(LoadingGetAvailableRooms());
      var result=await hotelsRepoImpl.getAvailableRooms(toJsonModel: GetAvailableRoomsModel(
        occupanciesList: occupanciesList,
        checkIn: checkIn,
        checkOut: checkOut,
        hotelCode: hotelCode,
        // paxList: occupanciesList,
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
    else if(checkIn=="Check In" && checkOut=='Check Out'){
      emit(FailureGetAvailableRooms(errMessage: "You must Define Date to stay"));
    }
    else{
      emit(FailureGetAvailableRooms(errMessage: "You must have at least one adult or Rooms can't be empty"));
    }

  }

  void changeRoomNum({required bool increase}){
    if(increase){
      roomNum++;
      occupanciesList.add(OccupanciesModel());
    }
    else {
      if(roomNum>0){
        roomNum --;
        occupanciesList.removeLast();
      }
    }
    emit(ChangeRoomNumberState());

  }

  void showOrClosePickOccupancies(){
    showOccupancies?showOccupancies=false:showOccupancies=true;
    emit(ShowOccupanciesState());
  }

  void fillPaxList({required int index,required String val,required int occupancyIndex}){
    int age=int.parse(val);
    occupanciesList[occupancyIndex].paxList?.insert(index, PaxModel(age: age, type: 'CH'));
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