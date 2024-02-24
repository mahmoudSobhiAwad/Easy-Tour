import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';

abstract class GenerateAiTripState{}
class InitialGenerateTripState extends GenerateAiTripState {}
class ChangeCurrPageIndex extends GenerateAiTripState {}
class ChangeRangeDatePickerState extends GenerateAiTripState {}
class AddPlaceToPickedPlacesList extends GenerateAiTripState {}
class RemovePlaceFromPickedPlacesList extends GenerateAiTripState {}
class ChangeToggleForSelectedTypeState extends GenerateAiTripState {}
class LoadingSendRequestToGenerateTrip extends GenerateAiTripState {}
class SuccessSendRequestToGenerateTrip extends GenerateAiTripState {
  final GeneratedTripModel model;
  SuccessSendRequestToGenerateTrip({required this.model});
}
class FailureSendRequestToGenerateTrip extends GenerateAiTripState {
  final String?errMessage;
  FailureSendRequestToGenerateTrip({this.errMessage});
}

