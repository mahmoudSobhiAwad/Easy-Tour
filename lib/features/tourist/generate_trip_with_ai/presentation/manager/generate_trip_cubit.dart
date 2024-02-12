import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_state.dart';

class GenerateAiTripCubit extends Cubit<GenerateAiTripState>{
  GenerateAiTripCubit():super(InitialGenerateTripState());
  int pageCurrIndex=SetAppState.prefs?.getInt('tripIndex')??0;
  String ?firstPickedDay;
  String? lastPickedDay;
  int? numOfDay;
  List<String>pickedPlaces=[];
  List<String>?pickedTypes;
  List<TypeOfTourism>typeOfTourismList=[
    TypeOfTourism(typeImage:'assets/tourist_home/historical places.png', typeName: 'Historical', picked: false),
    TypeOfTourism(typeImage:'assets/tourist_home/historical places.png', typeName: 'Beach&Sea',picked: false),
    TypeOfTourism(typeImage:'assets/tourist_home/historical places.png', typeName: 'Safari',picked: false),
    TypeOfTourism(typeImage:'assets/tourist_home/historical places.png', typeName: 'Islamic',picked: false),
  ];
  void navToGenerateTripScreen()async{
    pageCurrIndex=1;
    await SetAppState.generateTripCurrentPage(1);
    emit(ChangeCurrPageIndex());
  }
  void getRangeDate(BuildContext context)async{
    DateTimeRange? dateTimeRange= await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+3, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Pick',
    );
    if(dateTimeRange!=null)
    {
    firstPickedDay=dateTimeRange.start.toString().split(' ')[0];
    lastPickedDay=dateTimeRange.end.toString().split(' ')[0];
    numOfDay=dateTimeRange.duration.inDays;
    emit(ChangeRangeDatePickerState());
    }

  }
  void addToPlaces(String?value){
    if(pickedPlaces.isNotEmpty&&!pickedPlaces.contains(value))
    {
      pickedPlaces.add(value??"");
      emit(AddPlaceToPickedPlacesList());
    }
    else if(pickedPlaces.isEmpty){
      pickedPlaces.add(value??"sa");

      emit(AddPlaceToPickedPlacesList());
    }
  }
  void removeFromPlaces(int index){
    if(pickedPlaces.isNotEmpty)
    {
      pickedPlaces.removeAt(index);
      emit(RemovePlaceFromPickedPlacesList());
    }
  }
  void toggleBetweenTypes(int index) {
    if(typeOfTourismList[index].picked==true){
      typeOfTourismList[index].picked=false;
      pickedTypes?.remove(typeOfTourismList[index].typeName);
    }
    else{
      typeOfTourismList[index].picked=true;
      pickedTypes?.add(typeOfTourismList[index].typeName);
    }
    emit(ChangeToggleForSelectedTypeState());

  }


}