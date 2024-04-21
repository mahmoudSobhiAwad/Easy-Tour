abstract class GoogleMapStates{}
class InitialGoogleMapState extends GoogleMapStates {}
class InitialCameraPositionSuccessState extends GoogleMapStates {}
class AllowLocationSuccessState extends GoogleMapStates {}
class AllowLocationFailedState extends GoogleMapStates {
  final String?errMessage;
  AllowLocationFailedState({this.errMessage});
}
class ClearAllPlacesSearchList extends GoogleMapStates {}
class ChangeMyLivePositionInMapState extends GoogleMapStates {}
class LoadingGetTextSearchList extends GoogleMapStates {}
class SuccessGetTextSearchList extends GoogleMapStates {}
class FailureGetTextSearchList extends GoogleMapStates {
  final String?errMessage;
  FailureGetTextSearchList({this.errMessage});
}
class LoadingGetRoutePolyLinesList extends GoogleMapStates {}
class SuccessGetRoutePolyLinesList extends GoogleMapStates {}
class FailureGetRoutePolyLinesList extends GoogleMapStates {
  final String?errMessage;
  FailureGetRoutePolyLinesList({this.errMessage});
}
class UpdateLatLngBoundsAfterGetRoute extends GoogleMapStates {}
class AddNewMarkersWhenPushOnMap extends GoogleMapStates {}
