import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/repos/custom_trip_repo_impl.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_states.dart';

class CustomTripCubit extends Cubit<CustomTripState>{
  CustomTripCubit({this.pickedCompleteTrip,required this.customTripRepoImpl}):super(InitialCustomTripState());
  TextEditingController titleController=TextEditingController();
  String startDate='';
  String endDate='';
  int numOfDays=0;
  int once=0;
  bool isLoading=false;
  final formatter = DateFormat('d MMM y');
  CustomTripModel?pickedCompleteTrip;
  int toggleIndex=0;
  final CustomTripRepoImpl customTripRepoImpl;
  void changePickedDate(DateTimeRange? range)async{
    if(range!=null){
    DateTimeRange dateTimeRange= range;
    startDate=formatter.format(dateTimeRange.start);
    endDate=formatter.format(dateTimeRange.end);
    numOfDays=dateTimeRange.duration.inDays+1;
    emit(ChangeStartEndDateOfTripState());
    initListOfPlaces();
    }
  }
  void initEditCustomTrip(){
    if(pickedCompleteTrip!=null){
      startDate=pickedCompleteTrip?.startDate??"";
      endDate=pickedCompleteTrip?.endDate??"";
      titleController.text=pickedCompleteTrip?.title??"";
    }
    emit(ChangeStartEndDateOfTripState());
  }
  void initListOfPlaces(){
    pickedCompleteTrip?.tripDetailsList?.clear();
    for(int i=0;i<numOfDays;i++){
    pickedCompleteTrip?.tripDetailsList?.add(
      CustomTripDetailsModel(
        dayName: 'Day ${i+1}',
        daysDetailsList: [],
      ),
    );
    }
    emit(InitTripLengthState());
  }
  void refreshPage(){
    emit(InitTripLengthState());
  }
  void removeSpecificPlace(int bigIndex,int smallIndex){
    pickedCompleteTrip?.tripDetailsList?[bigIndex].daysDetailsList?.removeAt(smallIndex);
    emit(RemovePlaceFromPickedPlacesState());
  }

  void createCustomTrip()async{
    isLoading=true;
    emit(LoadingCreateOrEditTripState());
    var result=await customTripRepoImpl.createCustomTrips(data: pickedCompleteTrip!.toJson());
    result.fold((failure){
      isLoading=false;
      emit(FailureCreateOrEditTripState(errMessage: failure.errMessage));
    } , (data){
      isLoading=false;
      emit(SuccessCreateOrEditTripState());
    }
    );
  }

  void editCustomTrip()async{
    isLoading=true;
    emit(LoadingCreateOrEditTripState());
    var result=await customTripRepoImpl.editCustomTrip(data: pickedCompleteTrip!.toJson(),tripId: pickedCompleteTrip!.tripId!);
    result.fold((failure){
      isLoading=false;
      emit(FailureCreateOrEditTripState(errMessage: failure.errMessage));
    } , (data){
      isLoading=false;
      emit(SuccessCreateOrEditTripState());
    }
    );
  }
}