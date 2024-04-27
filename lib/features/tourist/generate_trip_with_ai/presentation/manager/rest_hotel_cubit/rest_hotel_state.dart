abstract class RestHotelDetailsState {}
class InitialRestHotelState extends RestHotelDetailsState {}
class LoadingGetPhotoOfPlace extends RestHotelDetailsState {}
class SuccessGetPhotoOfPlace extends RestHotelDetailsState {}
class ChangeToShowReviewState extends RestHotelDetailsState {}
class FailureGetPhotoOfPlace extends RestHotelDetailsState {
  final String?errMessage;
  FailureGetPhotoOfPlace({this.errMessage});
}
