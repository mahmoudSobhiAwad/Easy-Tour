abstract class TripsToViewStates{}
class InitialTripsToViewState extends TripsToViewStates {}
class MoveToSelectedDayInTrips extends TripsToViewStates {}
class LoadingGetAllTripsToViewState extends TripsToViewStates {}
class SuccessGetAllTripsToViewState extends TripsToViewStates {}
class FailureGetAllTripsToViewState extends TripsToViewStates {
  final String?errMessage;
  FailureGetAllTripsToViewState({this.errMessage});
}