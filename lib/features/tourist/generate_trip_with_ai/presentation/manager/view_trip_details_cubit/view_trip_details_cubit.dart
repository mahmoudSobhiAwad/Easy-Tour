import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';

class ViewTripDetailsCubit extends Cubit<ViewTripDetailsState>{
  ViewTripDetailsCubit({this.generatedTripModel,required this.nearbySearchRepoImp, this.generateTripRepoImp,this.endDate,required this.startDate}):super(InitialViewTripDetailsState());
  int currentDay=0;
  final NearbyPlacesRepoImpl nearbySearchRepoImp;
  final GeneratedTripModel? generatedTripModel;
  final GenerateTripRepoImp? generateTripRepoImp;
  final String? startDate;
  final String?endDate;
  final formatter = DateFormat('d MMM y');
  List<String>daysDatesName=[];
  PageController pageController=PageController();
  bool isLoading=false;
  bool showActivity=false;
  bool showRestaurants=false;
  bool showHotels=false;
  bool loadingRestaurants=false;
  bool loadingHotels=false;
  TextEditingController titleController=TextEditingController();
  FocusNode focusNode=FocusNode();
  List<NearbyPlacesModel> restaurant=[];
  List<NearbyPlacesModel> hotels=[];
  ScrollController controller=ScrollController();
  void pageChange(int index){
    currentDay=index;
    showRestaurants=false;
    showHotels=false;
    emit(MoveToNextDayState());
  }
  void addDaysDates(){
    DateTime firstDay=formatter.parse(startDate!);
    for(int i=0;i<4;i++){
      daysDatesName.add(formatter.format(firstDay.add(Duration(days: i+1))));
    }
  }
  void moveToNextDay(double width)
  {
    if(currentDay<generatedTripModel!.days.length-1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,);
      double offset = (currentDay + 1) * width;
      currentDay++;
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      showRestaurants=false;
      showHotels=false;
      emit(MoveToNextDayState());
    }

  }
  void moveToPrevDay(double width,)
  {
    if(currentDay>0){
      pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      double offset = (currentDay - 1) * width;
      currentDay--;
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      showRestaurants=false;
      showHotels=false;
      emit(MoveToPrevDayState());
    }
  }
  void moveToSpecificDay(int pageNum)
  {
   pageController.jumpToPage(pageNum);
   showRestaurants=false;
   showHotels=false;
   emit(MoveToPrevDayState());
  }
  Future<void> uploadTrip()async
  {
    isLoading=true;
    Map<String,dynamic>data={
      "title":titleController.text,
      "from":startDate,
      "to":endDate,
    };
    emit(LoadingUploadTripState());
    var result=await generateTripRepoImp!.uploadGeneratedDate(data: data);
    result.fold(
            (failure){
              isLoading=false;
              emit(FailedToUploadTripState());
            },
            (success){
              isLoading=false;
              titleController.clear();
              emit(SuccessToUploadTripState());
            }
    );

  }
  void changeShow(String show){
    switch(show){
      case 'activity':
        showActivity=!showActivity;
      case 'Restaurants':
        showRestaurants=!showRestaurants;
      case 'Hotels':
        showHotels=!showHotels;
    }
    emit(ChangeShowActivityState());
  }

  void getNearbyRestaurants()async{
    if(showRestaurants){
      showRestaurants=false;
      emit(ChangeShowActivityState());
    }
    else{
      showRestaurants=true;
      await getNearbyPlace('restaurant', restaurant,loadingRestaurants);
    }
  }
  void getNearbyHotels()async{
    if(showHotels){
      showHotels=false;
      emit(ChangeShowActivityState());
    }
    else{
      showHotels=true;
    await getNearbyPlace('hotel', hotels,loadingHotels);
    }
  }

  Future<void> getNearbyPlace(String type,List<NearbyPlacesModel>list,bool loading)async{
    emit(LoadingGetNearbyPlacesState());
    loading=true;
    var response=await nearbySearchRepoImp.getNearbyPlace(NearbyPlacesModel().toJson(type:type,long:31.227026858142505,lat:30.03414099707750,distance: 750,maxResult: 3));
    return response.fold((failure){
      loading=false;
      log(failure.errMessage.toString());
      emit(FailureGetNearbyPlacesState(errMessage: failure.errMessage));
    }, (places){
      list.clear();
      for(var item in places){
        list.add(item);
      }
      loading=false;
      emit(SuccessGetNearbyPlacesState());
    });
  }
}
