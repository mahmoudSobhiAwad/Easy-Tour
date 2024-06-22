import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/iata_codes_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/states.dart';

class GetTicketCubit extends Cubit<GetTicketsStates>{
  GetTicketCubit({required this.getTicketsRepoImpl}):super(InitialGetTicketsState());
  bool isLoading=false;
  TextEditingController departureController=TextEditingController();
  TextEditingController returnController=TextEditingController();
  TextEditingController fromController=TextEditingController();
  TextEditingController toController=TextEditingController();
  List<IatCodeModel>toIatCodesList=[];
  List<IatCodeModel>fromIatCodesList=[];
  List<GetTicketsModel> ticketsList=[];
  final String name=SetAppState.prefs?.getString('name')??"";
  final String profileUrl=SetAppState.prefs?.getString('profileUrl')??"";
  bool enableReturn=false;
  bool showOccupancy=false;
  DateTime? departureDate;
  DateTime? returnDate;
  int adultNum=1;
  Timer?debounce;
  int childNum=0;
  IatCodeModel? fromPlace;
  String accessToken='';
  IatCodeModel? toPlace;
  List<String> cabinTypes=["ECONOMY", "PREMIUM_ECONOMY", "BUSINESS", "FIRST"];
  String pickedCabin='ECONOMY';
  final GetTicketsRepoImpl getTicketsRepoImpl;

  void changeEnablingReturn(){
    enableReturn=!enableReturn;
    returnDate=null;
    returnController.text='';
    emit(ChangeEnableReturnDateState());
  }

  void swapBetweenFromTo(){
    String text=fromController.text;
    fromController.text=toController.text;
    toController.text=text;
    IatCodeModel? tempModel=fromPlace;
    fromPlace=toPlace;
    toPlace=tempModel;
    emit(ChangeOriginReturnCodeState());
  }

  void changeAdultOrChildNum({required bool adult,required bool increase}){
    if(adult){
      if(increase)
      {
      adultNum++;
      }
      else{
        if(adultNum>0){
          adultNum--;
        }
      }
    }
    else{
      if(increase)
      {
        childNum++;
      }
      else{
        if(childNum>0){
          childNum--;
        }
      }
    }
    emit(ChangeAdultOrChildNumState());
  }

  Future<void>getListOfFromAirPortTextSearch(String text)async{
    if(text.isNotEmpty&&text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
        await commonGetListSearch(text,true);
      }
    }
    else{
      fromIatCodesList.clear();
      emit(ClearIatCodesState());
    }
  }

  Future<void>getListOfToAirPortTextSearch(String text)async{
    if(text.isNotEmpty&&text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
       await commonGetListSearch(text,false);
      }
    }
    else{
      toIatCodesList.clear();
      emit(ClearIatCodesState());
    }
  }

  Future<void> commonGetListSearch(String text,bool fromOrTo) async{
    debounce=Timer(const Duration(milliseconds:1200), () async{
      emit(LoadingGetIatCodesState());
      var result=await getTicketsRepoImpl.getMatchedAirPorts(query: text);
      result.fold(
              (failure){
            emit(FailureGetIatCodesState(errMessage: failure.errMessage));
          },
              (result) {
                if(fromOrTo){
                  fromIatCodesList.clear();
                  for(var item in result){
                    fromIatCodesList.add(item);
                  }
                }
                else{
                  toIatCodesList.clear();
                  for(var item in result){
                    toIatCodesList.add(item);
                  }
                }
            emit(SuccessGetIatCodesState());
          });
    });
  }
  
  Future<void>getAccessToken()async{
    emit(LoadingGetAccessTokenState());
    var result=await getTicketsRepoImpl.getAccessToken(data:{
      'client_id':'AirgInEAzLk1QDoIeEHHk0vns2G8c7G8',
      'client_secret':'oHm6NcXleQeTVSwY',
      'grant_type':'client_credentials',
    });
    result.fold((failure){
      emit(FailureGetTicketsState(errMessage: failure.errMessage));
    }, (token){
      accessToken=token;
      emit(SuccessGetAccessTokenState());
    });
  }
  bool checkBeforeSend(){
    if(departureDate==null){
      return false;
    }
    else if(toPlace==null||fromPlace==null){
      return false;
    }

    else {
      return true;
    }
  }

  Future<void>getListOfTickets()async{
    if(checkBeforeSend()){
      emit(LoadingGetTicketsState());
      isLoading=true;
      var result=await getTicketsRepoImpl.getTicketsOfTripByOfferSearch(
          data: GetTicketsModel(
          travelersTypes: travelersType(),
          cabinType: pickedCabin,
          goingTrip: OriginDestinations(
            departureReturnTime:returnDate!=null?DateFormat('yyyy-MM-dd').format(returnDate!):null,
            departureIatCode: toPlace?.airportCode,
            departureLeaveTime:departureDate!=null?DateFormat('yyyy-MM-dd').format(departureDate!):null,
            originIatCode: fromPlace?.airportCode,)).toJson(),
          check: returnDate==null?false:true,
          accessToken: accessToken);

      result.fold((failure)async {
        isLoading=false;
        if(failure.statusCode==401){
          await getAccessToken();
        }
        emit(FailureGetTicketsState(errMessage: failure.errMessage));
      },
              (tickets) {
            ticketsList.clear();
            isLoading=false;

            for(var item in tickets){
              ticketsList.add(item);
            }
            emit(SuccessGetTicketsState(ticketsList: ticketsList));
          });
    }
    else{
      emit(FailureGetTicketsState(errMessage: 'There are Some uncompleted Date'));
    }

  }
  
  List<String>travelersType(){
    List<String>travelers=[];
    for(int i=0;i<adultNum;i++){
      travelers.add('ADULT');
    }
    for(int i=0;i<childNum;i++){
      travelers.add('CHILD');
    }
    return travelers;
  }

  void enableChangeAdultOrChild(){
    showOccupancy=!showOccupancy;

    emit(ChangeShowOccupancyState());
  }

  void changeCabinType(int index){
    pickedCabin=cabinTypes[index];
    emit(ChangeCabinTypeState());
  }

  void changeDepartureOrReturnDate({required DateTime time,required bool departure}){
    if(departure){
      departureController.text=time.toString();
      departureDate=time;
    }
    else{
      returnController.text=time.toString();
      returnDate=time;
    }
    emit(ChangeDepartureOrArrivalDateState());
  }

  void pickIatCodesFromAndTo({required IatCodeModel model,required bool from}){
    if(from){
      fromPlace=model;
      fromController.text='${model.countryName}-${model.cityName}';
    }
    else{
      toPlace=model;
      toController.text='${model.countryName}-${model.cityName}';
    }
    emit(ChangeFromToPlaceState());
  }
}