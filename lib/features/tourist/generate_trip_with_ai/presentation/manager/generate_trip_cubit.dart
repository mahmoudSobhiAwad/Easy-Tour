import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/data_ui.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/destination_with_number_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_state.dart';
class GenerateAiTripCubit extends Cubit<GenerateAiTripState>{
  GenerateAiTripCubit({required this.generateTripRepoImp}):super(InitialGenerateTripState());
  final GenerateTripRepoImp generateTripRepoImp;
  int pageCurrIndex=SetAppState.prefs?.getInt('tripIndex')??0;
  bool isLoading=false;
  final formatter = DateFormat('d MMM y');
  late Position? position;
  int? currActivity;
  int totalNumOfDays=0;
  List<DestinationPlaceDayModel>destinationWithDayList=[DestinationPlaceDayModel()];
  List<String> pickedTypes=[];
  DateTime nextDate=DateTime.now();
  Map<int,String>activityNames={2:'2 activity',3:'3 activity',4:'4 or more activity'};
  List<TypeOfTourism>typeOfTourismList=[
    TypeOfTourism(typeImage:ancientEgyptianSite, typeName: 'Ancient Sites', picked: false),
    TypeOfTourism(typeImage:museumsAndCulturalCenter, typeName: 'Cultural Institutions',picked: false),
    TypeOfTourism(typeImage:naturalLandmarks, typeName: 'Archaeological Exhibitions',picked: false),
    TypeOfTourism(typeImage:islamicSite, typeName: 'Religious Sites',picked: false),
    TypeOfTourism(typeImage:historicalAndArchitecturalLandmark, typeName: 'Historical Sites',picked: false),
  ];
  void changeActivityIndex(int index)
  {
    currActivity=index;
    emit(ChangePickedActivityIndexState());
  }
  void navToGenerateTripScreen()async{
    pageCurrIndex=1;
    await SetAppState.generateTripCurrentPage(1);
    emit(ChangeCurrPageIndex());
  }
  bool checkBeforeSend(){
    if(pickedTypes.isEmpty){
      emit(NotEnoughDataSubmittedState(errMessage: 'Please Select What Are The Kinds of The Trip'));
      return false;
    }
    else if(position==null){
      emit(NotEnoughDataSubmittedState(errMessage: 'You Dont\'t Allow Your Position to Get Trip Ordered'));
      return false;
    }
    else{
      return true;
    }
  }
  void increaseDestinationWithDayList(){
    destinationWithDayList.add(DestinationPlaceDayModel());
    emit(AddPlaceToPickedPlacesList());
  }
  void decreaseDestinationWithDayList(int index){
    if(destinationWithDayList.length>1){
      destinationWithDayList.removeAt(index);
      emit(RemovePlaceFromPickedPlacesList());
    }
  }
  void editFirstDate(int index){
    if(index>0){
      nextDate=formatter.parse(destinationWithDayList[index-1].lastDate!);
      nextDate=nextDate.add(const Duration(days: 1));
    }
  }
  void getRangeDate(BuildContext context,int index)async{
    editFirstDate(index);
    DateTimeRange? dateTimeRange= await showDateRangePicker(
      context: context,
      firstDate: nextDate,
      lastDate: nextDate.add(const Duration(days:3)),
      currentDate:nextDate,
      saveText: 'Pick',
    );

    if(dateTimeRange!=null)
    {
      String firstPickedDay=formatter.format(dateTimeRange.start);
      String lastPickedDay=formatter.format(dateTimeRange.end);
      int numOfDay=dateTimeRange.duration.inDays+1;
      destinationWithDayList[index].numOfDay=numOfDay;
      destinationWithDayList[index].startDate=firstPickedDay;
      destinationWithDayList[index].lastDate=lastPickedDay;
      debugPrint(destinationWithDayList[index].numOfDay.toString());
      emit(ChangeRangeDatePickerState());
    }

  }
  void addToPlaces(String?value,int index){
    destinationWithDayList[index].placeName=value;
    emit(AddPlaceToPickedPlacesList());
  }
  void toggleBetweenTypes(int index) {
    if(typeOfTourismList[index].picked==true){
      typeOfTourismList[index].picked=false;
    }
    else{
      typeOfTourismList[index].picked=true;
    }
    emit(ChangeToggleForSelectedTypeState());
  }
  Future<void>requestGenerateTrip()async{
    for(var item in typeOfTourismList){
      if(item.picked==true){
        pickedTypes.add(item.typeName);
      }
    }
    Map<String, int> map = { for (var item in destinationWithDayList) item.placeName as String : item.numOfDay as int };
    if(checkBeforeSend()){
      emit(LoadingSendRequestToGenerateTrip());
      isLoading=true;
      var result=await generateTripRepoImp.requestToGenerateDate(data: RequestTripModel(
        lat: position?.latitude,
        long: position?.longitude,
        preferred: pickedTypes,
        governments:map,
        numOfPlaceInDay: activityNames.keys.elementAt(currActivity??0),
      ).toJsonEncode());
      result.fold((failure){
        emit(FailureSendRequestToGenerateTrip(errMessage:failure.errMessage));
        isLoading=false;
      }, (generatedTrip) {
        isLoading=false;
        if(generatedTrip.days.isEmpty){
          emit(FailureSendRequestToGenerateTrip(errMessage:'Sorry No Date Please try to Pick Different Data'));
        }
        else
        {
          emit(SuccessSendRequestToGenerateTrip(startDate:destinationWithDayList.last.startDate,model:generatedTrip ));
        }
      });
    }
  }

  // Future<void> requestAllowLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   position=await Geolocator.getCurrentPosition();
  // }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('location is denied');
      //emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.' ));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location is denied');      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('location is denied');
    }
    position=await Geolocator.getCurrentPosition();
    return await Geolocator.getCurrentPosition();
  }
}
