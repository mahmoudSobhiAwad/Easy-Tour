abstract class PaymentPersonalDataStates{}

class InitialPaymentPersonalDateState extends PaymentPersonalDataStates {}

class InitPayPaxDateState extends PaymentPersonalDataStates {}

class ChangeOrAdultNumberInSpecificRoom extends PaymentPersonalDataStates {}

class ToggleBetweenPages extends PaymentPersonalDataStates {}
class ChangeIconsOfPaymentState extends PaymentPersonalDataStates {}
class LoadingSendCheckOfBooking extends PaymentPersonalDataStates {}
class SuccessSendCheckOfBooking extends PaymentPersonalDataStates {}

class FailureSendCheckOfBooking extends PaymentPersonalDataStates {
  final String?errMessage;
  FailureSendCheckOfBooking({this.errMessage});
}

class LoadingPaymentOfBooking extends PaymentPersonalDataStates {}
class SuccessPaymentOfBooking extends PaymentPersonalDataStates {}

class FailurePaymentOfBooking extends PaymentPersonalDataStates {
  final String?errMessage;
  FailurePaymentOfBooking({this.errMessage});
}