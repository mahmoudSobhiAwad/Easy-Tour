abstract class RoomsViewState{}
class InitialRoomsViewState extends RoomsViewState{}
class LoadingFacilityDataState extends RoomsViewState {}
class SuccessFacilityDataState extends RoomsViewState {}
class FailureFacilityDataState extends RoomsViewState {
  final String?errMessage;
  FailureFacilityDataState({this.errMessage});
}
