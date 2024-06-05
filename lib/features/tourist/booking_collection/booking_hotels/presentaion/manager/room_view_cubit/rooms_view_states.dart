import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';

abstract class RoomsViewState{}
class InitialRoomsViewState extends RoomsViewState{}
class LoadingFacilityDataState extends RoomsViewState {}
class SuccessFacilityDataState extends RoomsViewState {}
class FailureFacilityDataState extends RoomsViewState {
  final String?errMessage;
  FailureFacilityDataState({this.errMessage});
}
class ChangeNumOfBookedRoom extends RoomsViewState {}
class FailureIncreaseRoomNumState extends RoomsViewState {
  final String?errMessage;
  FailureIncreaseRoomNumState({this.errMessage});
}
class InitNeededRoomsList extends RoomsViewState {
  final List<GetAvailableRoomsModel>rooms;
  InitNeededRoomsList({required this.rooms});
}
