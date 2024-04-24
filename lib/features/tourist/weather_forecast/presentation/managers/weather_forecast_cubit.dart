import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/models/weather_forecast_model.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/repos/get_forecast_repo_imp.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/managers/weather_forecast_states.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastStates>{
  WeatherForecastCubit({required this.forecastRepoImpl}):super(InitialWeatherForecastState());
  final GetForecastRepoImpl forecastRepoImpl;
  int currDay=0;
  bool isLoading=true;
  bool enableMyLocation=false;
  List<WeatherForecastModel>weatherForecastModel=[];
  Position? myLocation;
  String?city;
  void changeDayToShow(int index){
    currDay=index;
    emit(ChangeCurrentDayToShow());
  }
  Future<void> getAddressFromLatLng() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(myLocation!.latitude, myLocation!.longitude);
    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks[0];
      city=getSplitedText(place.administrativeArea??'cairo');
      debugPrint(city);
    }
  }

  String getSplitedText(String text){
    List<String> parts = text.split(" Governorate");
    String result = parts[0].toLowerCase();
    return result;
  }

  Future<void>getForecastWeatherList()async {
    weatherForecastModel.clear();
    emit(LoadingGetWeatherForecastingState());
    isLoading=true;
    var result=await forecastRepoImpl.getForecastWeather(city??"cairo");
    result.fold((failure){
      isLoading=false;
      emit(FailureGetWeatherForecastingState(errMessage: failure.errMessage));
    }, (model) {
      for(var item in model){
        weatherForecastModel.add(item);
      }
      isLoading=false;
      emit(SuccessGetWeatherForecastingState());
    });
  }
  Future<void>getLocationDetails()async{
    myLocation= await determinePosition();
    if(myLocation!=null){
      await getAddressFromLatLng();
      if(city!=null){
        emit(AllowLocationSuccessState());
      }
    }
  }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.' ));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(AllowLocationFailedState(errMessage:'You don\'t allow Location to app ' ));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.'));
    }
    return await Geolocator.getCurrentPosition();
  }
  void changeCityFromList(String?value)async{
    if(value!=city){
      city=value;
      emit(ChangeCityValueState());
     await getForecastWeatherList();
    }
  }
}
