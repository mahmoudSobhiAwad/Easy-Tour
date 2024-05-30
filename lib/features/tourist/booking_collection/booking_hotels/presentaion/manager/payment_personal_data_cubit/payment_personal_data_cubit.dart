import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/payment_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_states.dart';

class PaymentPersonalDataCubit extends Cubit<PaymentPersonalDataStates>{
  PaymentPersonalDataCubit({required this.neededRooms}):super(InitialPaymentPersonalDateState());
  TextEditingController holderFirstNameController=TextEditingController();
  TextEditingController holderSurNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController clientController=TextEditingController();
  TextEditingController remarkController=TextEditingController();
  List<GetAvailableRoomsModel>neededRooms=[];
  List<PaxPayModel>payPaxList=[];
  List<RoomsInPayment>roomInPaymentList=[];
  late PaymentModel paymentModel;
  int currentPage=0;
  void preparePayList ()
  {
    for(var item in neededRooms){
      payPaxList.add(PaxPayModel(
        rateKey: item.rateOfRoom![0].rateKey,
        roomName:item.roomName,deadTime: item.rateOfRoom?[0].cancelPolicies?[0].deadTime,
        boardName:item.rateOfRoom?[0].boardName,
        cancelPrice:item.rateOfRoom?[0].cancelPolicies?[0].amount,));
    }

    emit(InitPayPaxDateState());
  }
  void onChangeText({required int totalIndex,required int smallIndex,String?name,String?type,String?surName}){
    payPaxList[totalIndex].paxList?[smallIndex].firstName=name??"";
    payPaxList[totalIndex].paxList?[smallIndex].surName=surName??"";
    payPaxList[totalIndex].paxList?[smallIndex].type=type??"";
    payPaxList[totalIndex].paxList?[smallIndex].roomId=totalIndex+1;
  }
  void changeAdultOrChildNumInSpecificRoom({required int roomIndex,required bool increase ,required bool adult}){
    if(increase){
      if(adult)
      {
        payPaxList[roomIndex].adultNum++;
      }
      else
      {
        payPaxList[roomIndex].childNum++;
      }
    }
    else {
      if(adult&&payPaxList[roomIndex].adultNum>0)
      {
        payPaxList[roomIndex].adultNum--;
      }
      else if(adult==false&&payPaxList[roomIndex].childNum>0)
      {
        payPaxList[roomIndex].childNum--;
      }
    }
    emit(ChangeOrAdultNumberInSpecificRoom());
  }

  void toggleBetweenPages(int index){
    currentPage=index;
    emit(ToggleBetweenPages());
  }

  void initPaymentModel(){
    for(var item in payPaxList){
      roomInPaymentList.add(
          RoomsInPayment(rateKey: item.rateKey, paxInPaymentList:fillPaxInPayment(item.paxList??[]))
      );
    }
    paymentModel=PaymentModel(
        surName: holderFirstNameController.text,
        name: holderSurNameController.text,
        roomsInPaymentList: roomInPaymentList,
        remark: remarkController.text,
        clientRef: clientController.text,
        email: emailController.text,
        phone: phoneController.text);
    print(paymentModel);

  }
  List<PaxInPayment> fillPaxInPayment(List<OnePaxModel>paxList){
    List<PaxInPayment>paxInPayment=[];
    for(var item in paxList){
      paxInPayment.add(PaxInPayment(type: item.type, name: item.firstName, roomId: item.roomId, surName: item.surName));
    }
    return paxInPayment;
  }

}