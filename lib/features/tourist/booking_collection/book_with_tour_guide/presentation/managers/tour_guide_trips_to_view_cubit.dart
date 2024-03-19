import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_all_tour_guide_trips_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_states.dart';

class TripsToViewCubit extends Cubit<TripsToViewStates>{
  int? tripsLength=0;
  TripsToViewCubit({this.tourGuideTripsForTouristRepoImp}):super(InitialTripsToViewState());
  final TourGuideTripsForTouristRepoImp? tourGuideTripsForTouristRepoImp;
  bool isLoading=false;
  List<Trip>tripList=[];
  int currIndex=0;
  int maxNumber=3;
  List<int>paginationList=[];
  int currDay=0;
  ScrollController scrollController=ScrollController();
  void changeIndex(int index)async{
    currIndex=index;
    emit(ChangePaginationInTripsOfGuide());
    await getAllTrips();
  }
  void scrollToNextItem({bool isPrevious = false,required double width})async {
    if(currIndex<paginationList.length-1){
      double offset = (currIndex+ 1) * width;
      currIndex++;
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,);
      emit(ChangePaginationInTripsOfGuide());
      await getAllTrips();
    }
  }
  void scrollToPrevItem({bool isPrevious = false,required double width})async {
    if(currIndex>0){
      double offset = (currIndex- 1) * width;
      currIndex--;
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,);
      emit(ChangePaginationInTripsOfGuide());
      await getAllTrips();
    }

  }

  Future<void>getAllTripsLength()async{
    isLoading=true;
    emit(LoadingGetAllTripsLengthState());
    var result=await tourGuideTripsForTouristRepoImp?.getAllTripsLength();
    result?.fold((failure) {
      isLoading=false;
      emit(FailureGetAllTripsLengthState(errMessage: failure.errMessage));
    }, (success)async{
      tripsLength=success;
      fillPageList();
      emit(SuccessGetAllTripsLengthState());
      await getAllTrips();
    });
  }
  void fillPageList(){
    double tripLengthD=tripsLength?.toDouble()??0;
    int pagNumbers=(tripLengthD/3.0).round();
    for(int i=0;i<pagNumbers;i++){
      paginationList.add(i+1);
    }
  }
  Future<void> getAllTrips()async{
    tripList.clear();
    Map<String,dynamic>queryParam={
      'page':currIndex+1,
      'size':3,
    };
    isLoading=true;
    emit(LoadingGetAllTripsToViewState());
    var result=await tourGuideTripsForTouristRepoImp?.getAllTourGuideTrips(queryParam);
    result?.fold((failure) {
      if(failure.statusCode==401){
        getAllTrips();
      }
      else{
      emit(FailureGetAllTripsToViewState(errMessage: failure.errMessage));
      log(failure.errMessage.toString());
      isLoading=false;
      }
    }, (trips)async{
      tripList.addAll(trips);
      await editTrips();
      emit(SuccessGetAllTripsToViewState());
      isLoading=false;
    });
  }
  void goToSelectedDay(int index){
    currDay=index;
    emit(MoveToSelectedDayInTrips());
  }
  Future<void> editTrips()async{
    for(int i=0;i<tripList.length;i++)
    {
      if(tripList[i].guideEmail==null)
      {
        tripList.removeAt(i);
      }
    }
  }
}