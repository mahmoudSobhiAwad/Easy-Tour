abstract class ViewTripDetailsState{}
class InitialViewTripDetailsState extends ViewTripDetailsState {}
class MoveToNextDayState extends ViewTripDetailsState {}
class MoveToPrevDayState extends ViewTripDetailsState {}
class LoadingUploadTripState extends ViewTripDetailsState {}
class FailedToUploadTripState extends ViewTripDetailsState {
  final String?errMessage;
  FailedToUploadTripState({this.errMessage});
}
class SuccessToUploadTripState extends ViewTripDetailsState {}
class ChangeShowActivityState extends ViewTripDetailsState {}