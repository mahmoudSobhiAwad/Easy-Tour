abstract class TripManagerState{}

class InitialTripManagerState extends TripManagerState {}

class ChangeTripIndexState extends TripManagerState {}

class LoadingGetAllTripHistoryState extends TripManagerState {}

class SuccessGetAllTripHistoryState extends TripManagerState {}

class FailureGetAllTripHistoryState extends TripManagerState {
  final String?errMessage;
  FailureGetAllTripHistoryState({this.errMessage});
}