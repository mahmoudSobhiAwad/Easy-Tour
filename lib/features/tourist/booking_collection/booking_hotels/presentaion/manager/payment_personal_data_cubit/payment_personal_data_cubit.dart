import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/payment_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_states.dart';

class PaymentPersonalDataCubit extends Cubit<PaymentPersonalDataStates>{
  PaymentPersonalDataCubit({required this.neededRooms,required this.getHotelsRepoImpl}):super(InitialPaymentPersonalDateState());
  TextEditingController holderFirstNameController=TextEditingController();
  TextEditingController holderSurNameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController clientController=TextEditingController();
  TextEditingController remarkController=TextEditingController();
  TextEditingController creditCardNumber=TextEditingController();
  String expiryDate='';
  String cardName='';
  String securityCode='';
  List<GetAvailableRoomsModel>neededRooms=[];
  List<PaxPayModel>payPaxList=[];
  List<RoomsInPayment>roomInPaymentList=[];
  late PaymentModel paymentModel;
  final GetHotelsRepoImpl getHotelsRepoImpl;
  int currentPage=0;
  bool isLoading=false;
  VisaNameIcon? creditData;
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
  void onChangeText({required int totalIndex,String?name}){
    payPaxList[totalIndex].onePaxModel= PaxInPayment(type: "AD", name: name??"",);
  }

  void toggleBetweenPages(int index){
    currentPage=index;

    emit(ToggleBetweenPages());
  }

  void initPaymentModel(){
    for(var item in payPaxList){
      roomInPaymentList.add(
          RoomsInPayment(rateKey: item.rateKey,),
      );

    }
    paymentModel=PaymentModel(
      surName: holderFirstNameController.text,
      name: holderSurNameController.text,
      roomsInPaymentList: roomInPaymentList,
      remark: remarkController.text,
      clientRef: clientController.text,
      email: emailController.text,
      phone: phoneController.text,
      cardNumber: creditCardNumber.text.replaceAll(RegExp(r'\D'), ''),
      cardType: creditData?.name,
      creditCardName: cardName,
      securityCode: securityCode,
      expiryDate: expiryDate,
    );
  }
  void sendCheckBooking ()async{
    isLoading=true;
    initPaymentModel();
    emit(LoadingSendCheckOfBooking());
    var result=await getHotelsRepoImpl.bookRooms(toJsonModel: paymentModel.toJson());
    result.fold(
            (failure){
              emit(FailureSendCheckOfBooking(errMessage: failure.errMessage));
              isLoading=false;
            },
            (success){
              isLoading=false;
              emit(SuccessSendCheckOfBooking());
              toggleBetweenPages(1);
            });
  }
  void payAndBook ()async{
    isLoading=true;
    initPaymentModel();
    emit(LoadingPaymentOfBooking());
    var result=await getHotelsRepoImpl.bookAndPay(toJsonModel: paymentModel.withCreditToJson());
    result.fold(
            (failure){
              emit(FailurePaymentOfBooking(errMessage: failure.errMessage));
              isLoading=false;
            },
            (success){
              emit(SuccessPaymentOfBooking());
              isLoading=false;
            });
  }
  void changeVisaIcon(String?value){
    creditData=getVisaIcon(value??"");
    emit(ChangeIconsOfPaymentState());
  }
  void changeDateForm(String? value){
    RegExp regExp=RegExp(r'\D');
    expiryDate=value?.replaceAll(regExp,'')??"";
  }
  void onChangeCvv(String? value){
    RegExp regExp=RegExp(r'\D');
    securityCode=value?.replaceAll(regExp,'')??"";
  }

}

VisaNameIcon getVisaIcon(String input){
  String cleanedNumber = input.replaceAll(RegExp(r'\D'), '');
  if (cleanedNumber.startsWith('4')) {
    return VisaNameIcon(iconData: FontAwesomeIcons.ccVisa, name: 'VISA');
  } else if (cleanedNumber.startsWith('5')) {
    return VisaNameIcon(iconData: FontAwesomeIcons.ccMastercard, name: 'MASTERCARD');
  } else if (cleanedNumber.startsWith('3')) {
    if (cleanedNumber.startsWith('34') || cleanedNumber.startsWith('37')) {
      return VisaNameIcon(iconData: FontAwesomeIcons.ccAmex, name: 'AMEX');
    }
  } else if (cleanedNumber.startsWith('6'))
  {
    return VisaNameIcon(iconData: FontAwesomeIcons.ccDiscover, name: 'DISCOVER');
  }

  return VisaNameIcon(iconData: FontAwesomeIcons.question, name: 'UNKNOWN');
}
class VisaNameIcon{
  IconData iconData;
  String name;
  VisaNameIcon({required this.iconData,required this.name});
}