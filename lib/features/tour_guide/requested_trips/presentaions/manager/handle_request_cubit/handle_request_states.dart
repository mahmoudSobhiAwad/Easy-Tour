abstract class HandleRequestStates{}
class InitialHandleRequestState  extends HandleRequestStates {}
class LoadingSendHandleRequestState  extends HandleRequestStates {}
class SuccessSendHandleRequestState  extends HandleRequestStates {
  final String?message;
  SuccessSendHandleRequestState({this.message});
}
class FailureSendHandleRequestState  extends HandleRequestStates {
  final String?errMessage;
  FailureSendHandleRequestState({this.errMessage});
}