abstract class DiscoverPlacesStates {}
class InitialHistoricalPlacesState extends DiscoverPlacesStates{}
class ChangeFavIconsHistoricalPlacesState extends DiscoverPlacesStates{}
class ChangePaginationIndexState extends DiscoverPlacesStates{}
class LoadingGetPlacesState extends DiscoverPlacesStates{}
class SuccessGetPlacesState extends DiscoverPlacesStates{}
class FailureGetPlacesState extends DiscoverPlacesStates{
  final String?errMessage;
  FailureGetPlacesState({this.errMessage});
}
