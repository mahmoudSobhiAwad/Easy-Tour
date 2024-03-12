abstract class ChatOneToOneStates{}
class InitialChatOneToOneState extends ChatOneToOneStates{}
class LoadingAddToMessageOTOState extends ChatOneToOneStates{}
class SuccessAddToMessageOTOState extends ChatOneToOneStates{}
class FailureAddToMessageOTOState extends ChatOneToOneStates{}
class EnableSendMessageInOTOState extends ChatOneToOneStates{}
class LoadingGetAllChatOTOState extends ChatOneToOneStates{}
class SuccessGetAllChatOTOState extends ChatOneToOneStates{}
class FailureGetAllChatOTOState extends ChatOneToOneStates{
  final String? errMessage;
  FailureGetAllChatOTOState({this.errMessage});
}
class LoadingSendMessageToOtherState extends ChatOneToOneStates{}
class FailureSendMessageToOtherState extends ChatOneToOneStates{
  final String?errMessage;
  FailureSendMessageToOtherState({this.errMessage});
}
class SuccessSendMessageToOtherState extends ChatOneToOneStates{}

