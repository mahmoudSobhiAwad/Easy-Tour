abstract class GetCustomTripsState{}

class InitialGetCustomTripState extends GetCustomTripsState {}

class RefreshGetCustomTripState extends GetCustomTripsState {}

class LoadingGetCustomTripState extends GetCustomTripsState {}

class SuccessGetCustomTripState extends GetCustomTripsState {}

class FailureGetCustomTripState extends GetCustomTripsState {
  final String?errMessage;
  FailureGetCustomTripState({this.errMessage});
}

