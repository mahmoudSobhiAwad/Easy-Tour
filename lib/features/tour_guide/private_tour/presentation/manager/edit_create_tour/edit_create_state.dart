abstract class CreateEditPrivateTourState {}
class InitialCreateEditPrivateState extends CreateEditPrivateTourState {}
class AddDetailsDaySuccessState extends CreateEditPrivateTourState {}
class AddDetailsDayFailureState extends CreateEditPrivateTourState {}
class RemoveDetailsDaySuccessState extends CreateEditPrivateTourState {}
class GetImageFromCameraState extends CreateEditPrivateTourState {}
class GetImageFromGalleryState extends CreateEditPrivateTourState {}
class DeleteBGTourState extends CreateEditPrivateTourState {}
class EditBGTourSuccessState extends CreateEditPrivateTourState {}
class AddAnotherPlaceInOneDay extends CreateEditPrivateTourState {}
class LoadingCreateTrip extends CreateEditPrivateTourState {}
class SuccessCreateTrip extends CreateEditPrivateTourState {}
class FailureCreateTrip extends CreateEditPrivateTourState {
  final String? errMessage;
  FailureCreateTrip({this.errMessage});
}
class LoadingEditTrip extends CreateEditPrivateTourState {}
class SuccessEditTrip extends CreateEditPrivateTourState {}
class FailureEditTrip extends CreateEditPrivateTourState {
  final String? errMessage;
  FailureEditTrip({this.errMessage});
}