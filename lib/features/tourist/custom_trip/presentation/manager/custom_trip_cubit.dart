import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/repos/custom_trip_repo_impl.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_states.dart';

class CustomTripCubit extends Cubit<CustomTripState>{
  CustomTripCubit({required this.pickedCompleteTrip,required this.customTripRepoImpl,required this.editOrCreate}):super(InitialCustomTripState());
  TextEditingController titleController=TextEditingController();
  String startDate='';
  String endDate='';
  int numOfDays=0;
  int once=0;
  bool isLoading=false;
  final bool editOrCreate;
  final formatter = DateFormat('d MMM y');
  CustomTripModel pickedCompleteTrip;
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
    startDate=pickedCompleteTrip.startDate??"";
    endDate=pickedCompleteTrip.endDate??"";
    titleController.text=pickedCompleteTrip.title??"";
      emit(ChangeStartEndDateOfTripState());
  }
  void initListOfPlaces(){
    pickedCompleteTrip.tripDetailsList?.clear();
    pickedCompleteTrip.tripDetailsList=[];
    for(int i=0;i<numOfDays;i++){
      pickedCompleteTrip.tripDetailsList?.add(
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
  void removeSpecificPlace({required int bigIndex,required int smallIndex}){
    pickedCompleteTrip.tripDetailsList?[bigIndex].daysDetailsList?.removeAt(smallIndex);
    emit(RemovePlaceFromPickedPlacesState());
  }

  bool checkBeforeSend(){
    if(titleController.text.isEmpty||startDate.isEmpty||endDate.isEmpty){
      return false;
    }
    else if(pickedCompleteTrip.tripDetailsList?.any((element) => element.daysDetailsList!.isEmpty)??true){
      return false;
    }
    else{
     return true;
    }
  }

  void createCustomTrip()async{
   pickedCompleteTrip.startDate=startDate;
   pickedCompleteTrip.endDate=endDate;
   pickedCompleteTrip.title=titleController.text;
   if(checkBeforeSend()){
     isLoading=true;
     emit(LoadingCreateOrEditTripState());
     var result=await customTripRepoImpl.createCustomTrips(data: pickedCompleteTrip.toJson());
     result.fold((failure){
       isLoading=false;
       emit(FailureCreateOrEditTripState(errMessage: failure.errMessage));
     } , (data){
       isLoading=false;
       emit(SuccessCreateOrEditTripState());
     }
     );
   }
   else{
     emit(FailureCreateOrEditTripState(errMessage: "There is Un Completed Data"));
   }

  }

  void editCustomTrip()async{
    pickedCompleteTrip.startDate=startDate;
    pickedCompleteTrip.endDate=endDate;
    pickedCompleteTrip.title=titleController.text;
    isLoading=true;
    emit(LoadingCreateOrEditTripState());
    var result=await customTripRepoImpl.editCustomTrip(data: pickedCompleteTrip.toJson(),tripId: pickedCompleteTrip.tripId!);
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