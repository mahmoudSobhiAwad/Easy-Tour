import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/model/request_trip_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/book_request_with_guide/request_to_book_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/request_trip_cubit/request_trip_states.dart';
import 'package:intl/intl.dart';
class BookTripWithTGCubit extends Cubit<BookTripWithTGStates>{
  BookTripWithTGCubit({required this.tripId,this.tripTicket,required this.requestToBookTrip}):super(InitialRequestTripState());
  bool isLoadingRequest=false;
  Map<String,dynamic>?tripTicket;
  final RequestToBookTripWithGuideRepoImp requestToBookTrip;
  int indexTripType=0;
  double totalPrice=0;
  Country?pickedCountry;
  int travelerNumber=0;
  TextEditingController userNameController=TextEditingController();
  TextEditingController startTripDateController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController travelerNumberController=TextEditingController(text:'0');
  TextEditingController ageNumberController=TextEditingController();
  TextEditingController commentController=TextEditingController();
  String tripId;
  void changePickedDate(DateTime?dateTime){
    if(dateTime != null){
      startTripDateController.text=DateFormat.yMMMEd().format(dateTime);
      emit(ChangeStartDateTimeState());
    }
  }
  void initPrice(){
    num currentPrice=tripTicket?.values.elementAt(indexTripType)??0;
    totalPrice=currentPrice.toDouble();
    emit(ChangeRequestTripType());
  }

  void changeCountry(Country?country){
    if(country != null){
      pickedCountry=country;
      emit(ChangePickedCountryState());
    }
  }

  void changePickedTripType(int index){
    indexTripType=index;
    num currentPrice=tripTicket?.values.elementAt(indexTripType)??0;
    totalPrice=(travelerNumber+1)*currentPrice.toDouble();
    emit(ChangeRequestTripType());
  }
  void minusTravelerNumber(){
    travelerNumber = int.parse(travelerNumberController.text);
    if(travelerNumber>0){
      travelerNumber--;
      num currentPrice=tripTicket?.values.elementAt(indexTripType)??0;
      totalPrice=(travelerNumber+1)*currentPrice.toDouble();
    }
    travelerNumberController.text=travelerNumber.toString();
    emit(ChangeTravelerNumberState());

  }
  void increaseTravelerNumber(){
    travelerNumber = int.parse(travelerNumberController.text);
    if(travelerNumber<5){
      travelerNumber++;
      num currentPrice=tripTicket?.values.elementAt(indexTripType)??0;
      totalPrice=(travelerNumber+1)*currentPrice.toDouble();
    }
    travelerNumberController.text=travelerNumber.toString();
    emit(ChangeTravelerNumberState());
  }
  Future<void>sendRequestToBookWithTG()async{
    emit(LoadingSendRequestToBookTrip());
    isLoadingRequest=true;
    RequestTripModel requestTripModel=RequestTripModel(
      tripID: tripId,
      email: emailController.text,
      travelerNum: travelerNumberController.text,
      age: ageNumberController.text,
      tripType: tripTicket?.keys.elementAt(indexTripType).toString(),
      phoneNumber: phoneController.text,
      userName: userNameController.text,
      startTripDate: startTripDateController.text,
      comment: commentController.text,
      country:pickedCountry?.name.toString(),
      countryFlag:pickedCountry?.flagEmoji.toString(),
    );
    var result=await requestToBookTrip.sendRequestToBook(requestTripModel.toJson());
    result.fold(
            (failure){
              isLoadingRequest=false;
              emit(FailureSendRequestToBookTrip(errMessage: failure.errMessage));
            },
            (success){
              isLoadingRequest=false;
              emit(SuccessSendRequestToBookTrip());
            }
    );
  }
}
