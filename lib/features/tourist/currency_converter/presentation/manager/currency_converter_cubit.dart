import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/model/currency_converter_model.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/repos/currency_repo_imp.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_state.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterState>{
  CurrencyConverterCubit({required this.currencyRepoImpl,required this.nearbyPlacesRepoImpl}):super(InitialCurrencyConverterState());
  final CurrencyRepoImpl currencyRepoImpl;
  List<CurrencyCodesModel>currencyCodesList=[];
  final NearbyPlacesRepoImpl nearbyPlacesRepoImpl;
  CurrencyConverterModel?initialCurrency;
  List<NearbyPlacesModel>placesList=[];
  bool isLoading=true;
  List<String>nameWithIcon=[];
  Timer?debounce;
  Position? myLocation;
  TextEditingController inputAmountController=TextEditingController();
  TextEditingController outputAmountController=TextEditingController();
  TextEditingController radiusController=TextEditingController(text:'500');
  Future<void>getCurrencyCodeList()async{
    emit(LoadingGetCurrencyCodeState());
    var result=await currencyRepoImpl.getCurrencyCodes();
    result.fold(
            (failure) {
              isLoading=false;
              debugPrint(failure.errMessage);
              emit(FailureGetCurrencyCodeState(errMessage: failure.errMessage));
            },
            (codesList){
              for(var item in codesList){
                currencyCodesList.add(item);
              }
              fillBaseAndTargetCurrency();
              isLoading=false;
              emit(SuccessGetCurrencyCodeState());
            }
    );
  }
  void fillBaseAndTargetCurrency(){
    initialCurrency=CurrencyConverterModel(target: currencyCodesList[1], based: currencyCodesList[0]);
    for(var item in currencyCodesList){
      nameWithIcon.add('${item.currencyIcon}- ${item.currencyName}');
    }
  }
  Future<void>getConvertedCurrency()async{
    if(debounce?.isActive??false){
      debounce?.cancel();
    }
    else{
    debounce=Timer(const Duration(milliseconds: 250), () async{
    emit(LoadingGetCurrencyCodeState());
    var result=await currencyRepoImpl.getConvertedCurrency(based: initialCurrency!.based.currencyCode!, target: initialCurrency!.target.currencyCode!, amount: num.parse(inputAmountController.text));
    result.fold(
            (failure) {
          isLoading=false;
          emit(FailureGetCurrencyConvertedState(errMessage: failure.errMessage));
        },
            (outputAmount){
              isLoading=false;
              outputAmountController.text=outputAmount.toString();
              emit(SuccessGetCurrencyConvertedState());
        }
        );
    }
    );
  }
}
  void getIndexFromCurrencyCode(String code,{required String type}){
    int index=currencyCodesList.indexWhere((element) {
      return element.currencyName==code;
    });
    if(type=='base')
    {
      initialCurrency?.based=currencyCodesList[index];
    }
    else{
      initialCurrency?.target=currencyCodesList[index];
    }
    emit(ChangeBasedOrTargetCodeState());
  }
  void swapTwoCurrencies(){
    CurrencyConverterModel? tempCurrency=CurrencyConverterModel(target: initialCurrency!.target, based: initialCurrency!.based);
    initialCurrency?.based=tempCurrency.target;
    initialCurrency?.target=tempCurrency.based;
    emit(SwapBetweenBasedAndTargetState());

  }
  Future<void>getNearbyPlaces()async{
    await determinePosition();
    if(myLocation!=null){
      print(myLocation?.longitude);
      placesList.clear();
      emit(LoadingGetNearbyBanksState());
      var response=await nearbyPlacesRepoImpl.getNearbyPlace(NearbyPlacesModel().toJson(type:['bank','atm'],lat:myLocation!.latitude,long:myLocation!.longitude,distance: num.parse(radiusController.text).toDouble(),maxResult: 3),fieldMask: fieldMaskForShortNearby);
      return response.fold((failure){
        log(failure.errMessage.toString());
        emit(FailureGetNearbyBanksState(errMessage: failure.errMessage));
      }, (places){
        for(var item in places){
          placesList.add(item);
        }
        emit(SuccessGetNearbyBanksState());
      });
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
    myLocation=await Geolocator.getCurrentPosition();
    return await Geolocator.getCurrentPosition();
  }
}