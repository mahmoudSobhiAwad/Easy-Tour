abstract class PrivateTourStates{}
class InitialPrivateTourState extends PrivateTourStates {}
class LoadingGetALLPrivateTourState extends PrivateTourStates {}
class SuccessGetALLPrivateTourState extends PrivateTourStates {}
class FailureGetALLPrivateTourState extends PrivateTourStates {
  final String? errMessage;
  FailureGetALLPrivateTourState({this.errMessage});
}
class LoadingDeletePrivateTourState extends PrivateTourStates {}
class SuccessDeletePrivateTourState extends PrivateTourStates {
  final String? successMessage;
  SuccessDeletePrivateTourState({this.successMessage});
}
class FailureDeletePrivateTourState extends PrivateTourStates {
  final String? errMessage;
  FailureDeletePrivateTourState({this.errMessage});
}
class RefreshTokenFailureState extends PrivateTourStates {
  final String? errMessage;
  RefreshTokenFailureState({this.errMessage});
}


