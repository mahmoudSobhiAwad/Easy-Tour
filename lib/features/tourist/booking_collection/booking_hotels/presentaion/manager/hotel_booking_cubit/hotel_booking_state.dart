import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';

abstract class HotelBookingStates{}

class InitialHotelBookingState extends HotelBookingStates {}

class CompleteTextSearchForDestination extends HotelBookingStates {}

class ChangeCheckInCheckOutDate extends HotelBookingStates {}

class ChangeAdultOrChildrenOrRoomNumber extends HotelBookingStates {}

class LoadingGetHotelsState extends HotelBookingStates {}
class SuccessGetHotelsState extends HotelBookingStates {}
class FailureGetHotelsState extends HotelBookingStates {
  final String?errMessage;
  FailureGetHotelsState({this.errMessage});
}
class LoadingGetAvailableRooms extends HotelBookingStates {}
class SuccessGetAvailableRooms extends HotelBookingStates {
  final HotelModelWithRoomModel model;
  SuccessGetAvailableRooms({required this.model});
}
class FailureGetAvailableRooms extends HotelBookingStates {
  final String?errMessage;
  FailureGetAvailableRooms({this.errMessage});
}