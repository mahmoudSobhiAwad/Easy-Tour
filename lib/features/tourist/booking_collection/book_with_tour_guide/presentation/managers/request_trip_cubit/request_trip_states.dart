abstract class BookTripWithTGStates{}
class InitialRequestTripState extends BookTripWithTGStates {}
class ChangeRequestTripType extends BookTripWithTGStates {}
class ChangeTripPrice extends BookTripWithTGStates {}
class ChangeStartDateTimeState extends BookTripWithTGStates {}
class ChangeTravelerNumberState extends BookTripWithTGStates {}
class ChangePickedCountryState extends BookTripWithTGStates {}
class LoadingSendRequestToBookTrip extends BookTripWithTGStates {}
class SuccessSendRequestToBookTrip extends BookTripWithTGStates {}
class FailureSendRequestToBookTrip extends BookTripWithTGStates {
  final String?errMessage;
  FailureSendRequestToBookTrip({this.errMessage});
}
