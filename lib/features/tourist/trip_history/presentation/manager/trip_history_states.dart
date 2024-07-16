abstract class TripManagerState{}

class InitialTripManagerState extends TripManagerState {}

class ChangeTripIndexState extends TripManagerState {}

class ChangeReminderState extends TripManagerState {}

class LoadingGetAllTripHistoryState extends TripManagerState {}

class SuccessGetAllTripHistoryState extends TripManagerState {}

class ChangeRangeDatePickerState extends TripManagerState {}

class FailureGetAllTripHistoryState extends TripManagerState {
  final String?errMessage;
  FailureGetAllTripHistoryState({this.errMessage});
}

class LoadingDeleteTripState extends TripManagerState {}

class SuccessDeleteTripState extends TripManagerState {}

class FailureDeleteTripState extends TripManagerState {
  final String?errMessage;
  FailureDeleteTripState({this.errMessage});
}

class LoadingRepeatTripState extends TripManagerState {}

class SuccessRepeatTripState extends TripManagerState {}

class FailureRepeatTripState extends TripManagerState {
  final String?errMessage;
  FailureRepeatTripState({this.errMessage});
}

class LoadingSetReminderState extends TripManagerState {}

class SuccessSetReminderState extends TripManagerState {}

class FailureSetReminderState extends TripManagerState {
  final String?errMessage;
  FailureSetReminderState({this.errMessage});
}