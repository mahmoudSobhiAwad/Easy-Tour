import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';

abstract class HotelResultStates{}

class InitialHotelResultState extends HotelResultStates {}

class LoadingGetAvailableRooms extends HotelResultStates {}

class SuccessGetAvailableRooms extends HotelResultStates {
  final HotelModelWithRoomModel? model;
  SuccessGetAvailableRooms({this.model});
}

class FailureGetAvailableRooms extends HotelResultStates {
  final String?errMessage;
  FailureGetAvailableRooms({this.errMessage});
}

class ChangeCheckInCheckOutDate extends HotelResultStates {}

class ShowOccupanciesState extends HotelResultStates {}

class ChangeAdultOrChildrenOrRoomNumber extends HotelResultStates {}

class LoadingGetMoreHotels extends HotelResultStates {}

class SuccessGetMoreHotels extends HotelResultStates {}

class FailureGetMoreHotels extends HotelResultStates {
  final String?errMessage;
  FailureGetMoreHotels({this.errMessage});
}