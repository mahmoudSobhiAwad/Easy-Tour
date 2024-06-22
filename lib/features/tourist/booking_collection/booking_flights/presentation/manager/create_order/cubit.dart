import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/create_order_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/states.dart';

class CreateFlightOrderCubit extends Cubit<CreateFlightOrderStates>{
  CreateFlightOrderCubit({required this.travelerNum,required this.getTicketsRepoImpl}):super(InitialCreateFlightOrderState());
  bool isLoading=false;
  final int travelerNum;
  String accessToken='';
  final GetTicketsRepoImpl getTicketsRepoImpl;
  List<TravelersData>travelersData=[];
  TextEditingController remarkController=TextEditingController();
  void initTravelersDataList(){
    for (int i=0;i<travelerNum;i++){
      travelersData.add(TravelersData());
    }
  }

  void changeAnyTypeAndFillList({required int index,required CreateFlightTypes fieldType,required String fieldContent}){
    switch(fieldType){
      case CreateFlightTypes.fName:
        travelersData[index].fName=fieldContent;
      case CreateFlightTypes.lName:
        travelersData[index].lName=fieldContent;
      case CreateFlightTypes.email:
        travelersData[index].email=fieldContent;
      case CreateFlightTypes.gender:
        travelersData[index].gender=fieldContent;
      case CreateFlightTypes.dateBirth:
        travelersData[index].birthDate=fieldContent;
      case CreateFlightTypes.phoneNum:
        travelersData[index].phoneNum=fieldContent;
        case CreateFlightTypes.expiryDate:
        travelersData[index].docExpiryDate=fieldContent;
      case CreateFlightTypes.birthPlace:
        travelersData[index].docBirthPlace=fieldContent;
      case CreateFlightTypes.docNumber:
        travelersData[index].docNumber=fieldContent;
      case CreateFlightTypes.docType:
        travelersData[index].docType=fieldContent;
      case CreateFlightTypes.issuanceDate:
        travelersData[index].issuanceDate=fieldContent;
    }
    emit(ChangeNationalityState());
  }
  Future<void> checkConfirmation()async{
    isLoading=true;
    emit(LoadingSendFlightOrderState());
    var result=await getTicketsRepoImpl.createTripOrder(data: CreateFlightModel(tripId: '', travelersDate: travelersData).toJson(),remark: remarkController.text, accessToken: accessToken);
    result.fold((failure)async{
      if(failure.statusCode==401){
        await getAccessToken().then((value)async {
          await checkConfirmation();
        });
      }
      emit(FailureSendFlightOrderState());
    }, (success){
      emit(SuccessSendFlightOrderState());
    });
  }
  Future<void>getAccessToken()async{

    var result=await getTicketsRepoImpl.getAccessToken(data:{
      'client_id':'AirgInEAzLk1QDoIeEHHk0vns2G8c7G8',
      'client_secret':'oHm6NcXleQeTVSwY',
      'grant_type':'client_credentials',
    });
    result.fold((failure){

    }, (token){
      accessToken=token;

    });
  }
  void changeNationality(int index,Country? value){
    travelersData[index].nationality=value;
    emit(ChangeNationalityState());
  }
}
enum CreateFlightTypes{
  fName,lName,email,gender,dateBirth,phoneNum,expiryDate,birthPlace,docNumber,docType,issuanceDate
}