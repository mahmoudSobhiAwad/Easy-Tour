abstract class TripsToViewStates{}
class InitialTripsToViewState extends TripsToViewStates {}
class MoveToSelectedDayInTrips extends TripsToViewStates {}
class ChangePaginationInTripsOfGuide extends TripsToViewStates {}
class LoadingGetAllTripsToViewState extends TripsToViewStates {}
class SuccessGetAllTripsToViewState extends TripsToViewStates {}
class FailureGetAllTripsToViewState extends TripsToViewStates {
  final String?errMessage;
  FailureGetAllTripsToViewState({this.errMessage});
}
class LoadingGetAllTripsLengthState extends TripsToViewStates {}
class SuccessGetAllTripsLengthState extends TripsToViewStates {}
class FailureGetAllTripsLengthState extends TripsToViewStates {
  final String?errMessage;
  FailureGetAllTripsLengthState({this.errMessage});
}