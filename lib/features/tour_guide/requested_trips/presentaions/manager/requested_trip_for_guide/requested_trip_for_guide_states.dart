abstract class RequestedTripForGuideStates{}
class InitialRequestedTripForGuideStates extends RequestedTripForGuideStates {}
class LoadingGetRequestedTripForGuideStates extends RequestedTripForGuideStates {}
class SuccessGetRequestedTripForGuideStates extends RequestedTripForGuideStates {}
class FailureGetRequestedTripForGuideStates extends RequestedTripForGuideStates {
  final String?errMessage;
  FailureGetRequestedTripForGuideStates({this.errMessage});
}