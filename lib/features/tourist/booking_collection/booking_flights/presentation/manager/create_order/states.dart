abstract class CreateFlightOrderStates{}

class InitialCreateFlightOrderState extends CreateFlightOrderStates {}

class ChangeNationalityState extends CreateFlightOrderStates {}

class LoadingSendFlightOrderState extends CreateFlightOrderStates {}

class SuccessSendFlightOrderState extends CreateFlightOrderStates {}

class FailureSendFlightOrderState extends CreateFlightOrderStates {
  final String?errMessage;
  FailureSendFlightOrderState({this.errMessage});
}