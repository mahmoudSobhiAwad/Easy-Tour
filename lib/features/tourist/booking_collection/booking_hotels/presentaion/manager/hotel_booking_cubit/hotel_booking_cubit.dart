import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_state.dart';

class HotelBookingCubit extends Cubit<HotelBookingStates>{
  HotelBookingCubit({required this.hotelsRepoImpl,this.hotelList}):super(InitialHotelBookingState());
  TextEditingController searchText=TextEditingController();
  List<String> searchResults = [];
  Timer?debounce;
  List<HotelsModel>?hotelList=[];
  DestinationModel?destModel;
  List<String>facilityStringList=[];
  int totalNum=0;
  bool isLoading=false;

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


  void searchForHotelsByDestOnly(DestinationModel model)async{
    destModel=model;
    isLoading=true;
    emit(LoadingGetHotelsState());
    var result=await hotelsRepoImpl.getAllHotelsInDestination(destCode:model.destCode);
    result.fold((failure){
      isLoading=false;
      emit(FailureGetHotelsState(errMessage:failure.errMessage ));
      debugPrint(failure.errMessage);
    }, (hotels){
      hotelList=[];
      for(var item in hotels.hotelsList??[]){
        hotelList!.add(item);
      }
      totalNum=hotels.total;
      isLoading=false;
      emit(SuccessGetHotelsState());
    });
  }


}

