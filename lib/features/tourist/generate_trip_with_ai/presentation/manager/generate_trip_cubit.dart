import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/data_ui.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/generate_trip_state.dart';
class GenerateAiTripCubit extends Cubit<GenerateAiTripState>{
  GenerateAiTripCubit({required this.generateTripRepoImp}):super(InitialGenerateTripState());
  final GenerateTripRepoImp generateTripRepoImp;
  int pageCurrIndex=SetAppState.prefs?.getInt('tripIndex')??0;
  String ?firstPickedDay;
  String? lastPickedDay;
  int? numOfDay;
  bool isLoading=false;
  List<String>pickedPlaces=[];
  late Position position;
  TextEditingController numberOfPlaceInDayController=TextEditingController();
  List<String> pickedTypes=[];
  List<TypeOfTourism>typeOfTourismList=[
    TypeOfTourism(typeImage:ancientEgyptianSite, typeName: 'Ancient Egyptian Sites', picked: false),
    TypeOfTourism(typeImage:museumsAndCulturalCenter, typeName: 'Museums And Cultural Centers',picked: false),
    TypeOfTourism(typeImage:beachesAndWaterBodies, typeName: 'Beaches And Water Bodies',picked: false),
    TypeOfTourism(typeImage:safariAndAdventures, typeName: 'Safari and adventures',picked: false),
    TypeOfTourism(typeImage:historicalAndArchitecturalLandmark, typeName: 'Historical and Architectural Landmark',picked: false),
    TypeOfTourism(typeImage:islamicSite, typeName: 'Islamic Sites',picked: false),
    TypeOfTourism(typeImage:christianSite, typeName: 'Christian Site',picked: false),
    TypeOfTourism(typeImage:naturalLandmarks, typeName: 'Natural Landmarks',picked: false),
    TypeOfTourism(typeImage:entertainmentPlaces, typeName: 'Game And Entertainment Centers',picked: false),
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
     emit(LoadingSendRequestToGenerateTrip());
     isLoading=true;
     var result=await generateTripRepoImp.requestToGenerateDate(data: RequestTripModel(
       numOfPlaceInDay:int.parse(numberOfPlaceInDayController.text).toInt() ,
       numOfDay:numOfDay ,
       lat: position.latitude,
       long: position.longitude,
       preferred: pickedTypes,
       governments: pickedPlaces,
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
       emit(SuccessSendRequestToGenerateTrip(model: generatedTrip));
       }
     });
  }

  Future<void> requestAllowLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position=await Geolocator.getCurrentPosition();
  }
}