import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/iata_codes_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/states.dart';

class GetTicketCubit extends Cubit<GetTicketsStates>{
  GetTicketCubit({required this.getTicketsRepoImpl}):super(InitialGetTicketsState());
  bool isLoading=false;
  List<IatCodeModel>toIatCodesList=[];
  List<IatCodeModel>fromIatCodesList=[];
  List<GetTicketsModel> ticketsList=[];
  bool enableReturn=false;
  DateTime? departureDate;
  DateTime? returnDate;
  int adultNum=0;
  Timer?debounce;
  int childNum=0;
  IatCodeModel? fromPlace;
  String accessToken='';
  IatCodeModel? toPlace;
  List<String> cabinTypes=["ECONOMY", "PREMIUM_ECONOMY", "BUSINESS", "FIRST"];
  final GetTicketsRepoImpl getTicketsRepoImpl;

  void changeEnablingReturn(){
    enableReturn=!enableReturn;
    emit(ChangeEnableReturnDateState());
  }

  void swapBetweenFromTo(){
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

    fromIatCodesList.clear();
    if(text.isNotEmpty&&text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
        commonGetListSearch(text,fromIatCodesList);
      }
    }
    else{
      fromIatCodesList.clear();
    }
  }

  Future<void>getListOfToAirPortTextSearch(String text)async{

    toIatCodesList.clear();
    if(text.isNotEmpty&&text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
        commonGetListSearch(text,toIatCodesList);
      }
    }
    else{
      toIatCodesList.clear();
    }
  }

  void commonGetListSearch(String text,List<IatCodeModel>iatCodeList) {
    debounce=Timer(const Duration(milliseconds: 250), () async{
      emit(LoadingGetIatCodesState());
      var result=await getTicketsRepoImpl.getMatchedAirPorts(query: text);
      result.fold(
              (failure){
            emit(FailureGetIatCodesState(errMessage: failure.errMessage));
          },
              (result) {
            iatCodeList.clear();
            for(var item in result){
              iatCodeList.add(item);
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
  
  Future<void>getListOfTickets()async{
    emit(LoadingGetTicketsState());
    isLoading=true;
    var result=await getTicketsRepoImpl.getTicketsOfTripByOfferSearch(data: GetTicketsModel(
        travelersTypes: travelersType(),
        cabinType: cabinTypes[0],
        goingTrip: OriginDestinations(
          departureReturnTime:DateFormat('yyyy-MM-dd').format(returnDate!),
          departureIatCode: toPlace?.airportCode,
          departureLeaveTime: DateFormat('yyyy-MM-dd').format(departureDate!),
          originIatCode: fromPlace?.airportCode,)).toJson(), accessToken: accessToken);
    result.fold((failure)async {
      isLoading=false;
      if(failure.statusCode==401){
        await getAccessToken().then((value){
          getListOfTickets();
        });
      }
      else{
      emit(FailureGetTicketsState(errMessage: failure.errMessage));
      }
    }, (tickets) {
      ticketsList.clear();
      isLoading=false;
      for(var item in tickets){
        ticketsList.add(item);
      }
      emit(SuccessGetAccessTokenState());
    });
  }
  
  List<String>travelersType(){
    List<String>travelers=[];

    for(int i=0;i<childNum;i++){
      travelers.add('CHILD');
    }

    for(int i=0;i<adultNum;i++){
      travelers.add('ADULT');
    }

    return travelers;
  }
}