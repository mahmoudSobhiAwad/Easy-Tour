abstract class CustomTripState{}

class InitialCustomTripState extends CustomTripState {}

class ChangeStartEndDateOfTripState extends CustomTripState {}

class InitTripLengthState extends CustomTripState {}

class RemovePlaceFromPickedPlacesState extends CustomTripState {}

class ToggleBetweenPagesState extends CustomTripState {}

class LoadingCreateOrEditTripState extends CustomTripState {}

class SuccessCreateOrEditTripState extends CustomTripState {}

class FailureCreateOrEditTripState extends CustomTripState {
  final String?errMessage;
  FailureCreateOrEditTripState({this.errMessage});
}
