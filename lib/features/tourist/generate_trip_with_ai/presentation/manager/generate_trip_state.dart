import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';

abstract class GenerateAiTripState{}
class InitialGenerateTripState extends GenerateAiTripState {}
class ChangeCurrPageIndex extends GenerateAiTripState {}
class ChangeRangeDatePickerState extends GenerateAiTripState {}
class ChangePickedActivityIndexState extends GenerateAiTripState {}
class AddPlaceToPickedPlacesList extends GenerateAiTripState {}
class RemovePlaceFromPickedPlacesList extends GenerateAiTripState {}
class ChangeToggleForSelectedTypeState extends GenerateAiTripState {}
class LoadingSendRequestToGenerateTrip extends GenerateAiTripState {}
class SuccessSendRequestToGenerateTrip extends GenerateAiTripState {
  final GeneratedTripModel model;
  final String?startDate;
  final String?endDate;
  SuccessSendRequestToGenerateTrip({
    required this.model,
    required this.endDate,
    required this.startDate});
}
class FailureSendRequestToGenerateTrip extends GenerateAiTripState {
  final String?errMessage;
  FailureSendRequestToGenerateTrip({this.errMessage});
}
class NotEnoughDataSubmittedState extends GenerateAiTripState {
  final String?errMessage;
  NotEnoughDataSubmittedState({this.errMessage});
}


