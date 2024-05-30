abstract class HotelBookingStates{}

class InitialHotelBookingState extends HotelBookingStates {}

class CompleteTextSearchForDestination extends HotelBookingStates {}

class LoadingGetHotelsState extends HotelBookingStates {}

class SuccessGetHotelsState extends HotelBookingStates {}

class FailureGetHotelsState extends HotelBookingStates {
  final String?errMessage;
  FailureGetHotelsState({this.errMessage});
}
