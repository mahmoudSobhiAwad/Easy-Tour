abstract class StaticPlacesState{}
class InitialStaticPlacesState extends StaticPlacesState{}
class LoadingFetchStaticPlacesState extends StaticPlacesState{}
class SuccessFetchStaticPlacesState extends StaticPlacesState{}
class FailureFetchStaticPlacesState extends StaticPlacesState{
  final String?errMessage;
  FailureFetchStaticPlacesState({this.errMessage});
}