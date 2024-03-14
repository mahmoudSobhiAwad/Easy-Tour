abstract class GoogleMapStates{}
class InitialGoogleMapState extends GoogleMapStates {}
class InitialCameraPositionSuccessState extends GoogleMapStates {}
class AllowLocationSuccessState extends GoogleMapStates {}
class AllowLocationFailedState extends GoogleMapStates {
  final String?errMessage;
  AllowLocationFailedState({this.errMessage});
}
class ChangeMyLivePositionInMapState extends GoogleMapStates {}