import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';

abstract class GetTicketsStates{}

class InitialGetTicketsState extends GetTicketsStates {}

class ChangeEnableReturnDateState extends GetTicketsStates {}

class ChangeOriginReturnCodeState extends GetTicketsStates {}

class ChangeAdultOrChildNumState extends GetTicketsStates {}

class ChangeDepartureOrArrivalDateState extends GetTicketsStates {}

class ChangeFromToPlaceState extends GetTicketsStates {}

class ChangeShowOccupancyState extends GetTicketsStates {}

class ChangeCabinTypeState extends GetTicketsStates {}

class LoadingGetTicketsState extends GetTicketsStates {}

class SuccessGetTicketsState extends GetTicketsStates {
  final List<GetTicketsModel>ticketsList;
  SuccessGetTicketsState({required this.ticketsList});
}

class FailureGetTicketsState extends GetTicketsStates {
  final String?errMessage;
  FailureGetTicketsState({this.errMessage});
}

class LoadingGetIatCodesState extends GetTicketsStates {}

class SuccessGetIatCodesState extends GetTicketsStates {}

class ClearIatCodesState extends GetTicketsStates {}

class FailureGetIatCodesState extends GetTicketsStates {
  final String? errMessage;
  FailureGetIatCodesState({this.errMessage});
}

class LoadingGetAccessTokenState extends GetTicketsStates {}

class SuccessGetAccessTokenState extends GetTicketsStates {}

class FailureGetAccessTokenState extends GetTicketsStates {
  final String? errMessage;
  FailureGetAccessTokenState({this.errMessage});
}

