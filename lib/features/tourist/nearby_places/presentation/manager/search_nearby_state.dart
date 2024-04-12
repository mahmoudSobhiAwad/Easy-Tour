abstract class NearbySearchState{}
class InitialNearbySearchState extends NearbySearchState {}
class ChangeCategoryPickedSearchState extends NearbySearchState {}
class ChangeSearchResultList extends NearbySearchState {}
class LoadingGetNearbyPlacesState extends NearbySearchState{}
class SuccessGetNearbyPlacesState extends NearbySearchState{}
class FailureGetNearbyPlacesState extends NearbySearchState{
  final String?errMessage;
  FailureGetNearbyPlacesState({this.errMessage});
}