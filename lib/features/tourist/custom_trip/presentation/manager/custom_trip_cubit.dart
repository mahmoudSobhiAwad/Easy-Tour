import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_states.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';

class CustomTripCubit extends Cubit<CustomTripState>{
  CustomTripCubit():super(InitialCustomTripState());
  TextEditingController titleController=TextEditingController();
  String startDate='';
  String endDate='';
  int numOfDays=0;
  int once=0;
  final formatter = DateFormat('d MMM y');
  Map<String,List<Place>>pickedCompleteTrip={};
  int toggleIndex=0;
  void moveToNextPage(int index){
    toggleIndex=index;
    emit(ToggleBetweenPagesState());
  }
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
  void initListOfPlaces(){
    pickedCompleteTrip.clear();
    for(int i=0;i<numOfDays;i++){
    pickedCompleteTrip.addAll({'Day${i+1}':[]});
    }
    emit(InitTripLengthState());
  }
  void refreshPage(){
    emit(InitTripLengthState());
  }
  void removeSpecificPlace(int bigIndex,int smallIndex){
    pickedCompleteTrip['Day$bigIndex']?.removeAt(smallIndex);
    emit(RemovePlaceFromPickedPlacesState());
  }
}